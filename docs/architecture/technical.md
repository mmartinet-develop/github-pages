# 🔧 Détails techniques

## Exigences fonctionnelles

| Domaine | Exigence | Détail |
|---------|----------|---------|
| **Ingestion** | Fiabilité | Idempotence, retry, DLQ |
| **Performance** | Latence | < 200ms en moyenne |
| **Scalabilité** | Auto-scaling | Lambda + DynamoDB on-demand |
| **Isolation** | Multi-tenant | VPC par Team, IAM par env |
| **Observabilité** | Logs centralisés | CloudWatch + S3 archive |
| **Analytics** | ETL | Glue + Athena partitionnés |

## Exigences non-fonctionnelles

### Disponibilité
- RTO : 1h
- RPO : 15 min
- Multi-AZ obligatoire

### Performance
- Ingestion : < 200ms
- Requêtes analytics : < 30s (P95)
- Throughput : 1k events/sec par Team

### Coût
- Budget : €10-15/mois par POC
- Optimisation : DynamoDB on-demand, TTL S3

### Sécurité
- Least privilege IAM
- Encryption at rest & in transit
- CloudTrail audit trail
- GuardDuty enabled

---

## Stack technique

### Infrastructure
- **IaC** : Terraform
- **Modules** : VPC, IAM, Logging, Shared Services

### Compute
- **Serverless** : Lambda (Node.js, Python)
- **Event Bus** : SQS + Kafka
- **Orchestration** : Step Functions

### Storage
- **Transactionnel** : DynamoDB
- **Archive** : S3 (lifecycle policies)
- **Analytics** : S3 + Parquet format

### Data
- **ETL** : AWS Glue
- **Query** : Athena
- **BI** : QuickSight (optionnel)

### Monitoring
- **Logs** : CloudWatch Logs (centralisés)
- **Metrics** : CloudWatch + custom metrics
- **Alertes** : SNS notifications
- **Tracing** : X-Ray (optionnel)

---

## Budget estimé

```
Par Team/POC:
├── Lambda         : ~2€
├── DynamoDB       : ~3€
├── S3             : ~1€
├── Glue/Athena    : ~2€
├── Data transfer  : ~1€
└── Monitoring     : ~1€
─────────────────────
Total:            ~10€/mois
```

> 💡 Budget total pour 3 Teams : ~30€/mois

---

## Pattern d'architecture

### Ingestion
```
Client → API Gateway → Lambda → DynamoDB
                       ↓
              CloudWatch Logs (audit)
                       ↓
                  SNS Notification
```

### Event-driven
```
DynamoDB Stream → Lambda → SQS → Kafka → Consumers
                                          ├─ Team B
                                          ├─ Team C
                                          └─ Team D
```

### Analytics
```
S3 (raw) → Glue (ETL) → S3 (Parquet) → Athena (SQL)
```

---

## Voir aussi

- [Organisation AWS](organization.md)
- [Réseau & VPC](network.md)
- [Sécurité & IAM](security.md)
