# 🏛️ Organisation AWS

## Structure des comptes

```
AWS Organizations
│
├── Management Account (Billing + CloudTrail)
│   └── CloudTrail centralisé pour tous les comptes
│
└── Sandbox / Development OU
    ├── Account - Team A (Ingestion)
    ├── Account - Team B (Event-driven)
    ├── Account - Team C (Analytics)
    ├── Account - Team D (Dashboard/API)
    ├── Account - Team E (Security & Logging)
    └── Account - Shared Services
```

## VPC par Team

Chaque **Team** dispose d'une **VPC isolée** :

| Team | Fonction | VPC | Subnets | Services |
|------|----------|-----|---------|----------|
| **A** | Ingestion | 10.1.0.0/16 | Public + Private | Lambda, API GW, DynamoDB |
| **B** | Event-driven | 10.2.0.0/16 | Private | Kafka, Step Functions |
| **C** | Analytics | 10.3.0.0/16 | Private | Glue, Athena, S3 |
| **D** | Dashboard | 10.4.0.0/16 | Public + Private | API Lambda, CloudFront |
| **E** | Security | 10.5.0.0/16 | Private | CloudTrail, GuardDuty |

## Ressources partagées

```
Shared Services VPC (10.0.0.0/16)
├── Kafka Cluster
├── Monitoring central (CloudWatch, Alarms)
├── VPC Lattice Service Network
└── Logging centralisé (S3, CloudWatch Logs)
```

## Communication inter-VPC

- **VPC Lattice** : Service-to-service discovery et communication
- **VPC Peering** : Si nécessaire pour legacy
- **Transit Gateway** : Option pour hub-and-spoke avancée

---

## Voir aussi

- [Vue d'ensemble architecture](overview.md)
- [Sécurité & IAM](security.md)
