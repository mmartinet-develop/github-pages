# 🏗️ Vue d'ensemble de l'architecture

## Objectif

Le Mini-Lab SaaS est un **SaaS modulaire event-driven** conçu pour :
- Collecter, traiter et analyser des événements
- Fonctionner dans une architecture AWS multi-compte
- Démontrer des patterns d'architecture d'entreprise

## Principes clés

### 📦 Modularité
- Architecture basée sur des **Teams** (POC) indépendants
- Chaque Team dispose d'une VPC dédiée
- Modules Terraform réutilisables

### 🔌 Intégration
- Communication sécurisée via **VPC Lattice**
- Services partagés (Kafka, Monitoring, etc.)
- API Gateway pour l'exposition externes

### 📈 Scalabilité
- Serverless-first (Lambda, DynamoDB)
- Event-driven avec queues (SQS/Kafka)
- Analytics distributed (Glue + Athena)

### 🔐 Sécurité
- Principle of least privilege (IAM)
- Isolation VPC stricte
- CloudTrail centralisé

---

## Architecture de haut niveau

```
┌─────────────────────────────────────────────────┐
│         Management Account (CloudTrail)          │
├─────────────────────────────────────────────────┤
│                                                   │
│  ┌──────────────┐  ┌──────────────┐             │
│  │  VPC Team A  │  │  VPC Team B  │  ...        │
│  │  (Ingestion) │  │  (Events)    │             │
│  └──────────────┘  └──────────────┘             │
│         ↓                  ↓                      │
│    ┌──────────────────────────────┐             │
│    │      VPC Lattice             │             │
│    │   (Service Network)           │             │
│    └──────────────────────────────┘             │
│                                                   │
│  ┌──────────────┐  ┌──────────────┐             │
│  │ Shared Svc   │  │ Analytics    │             │
│  │ (Kafka, S3)  │  │ (Athena)     │             │
│  └──────────────┘  └──────────────┘             │
│                                                   │
└─────────────────────────────────────────────────┘
```

---

## Composants principaux

| Composant | Rôle | Technology |
|-----------|------|-----------|
| **Ingestion** | Récupter événements clients | Lambda + API Gateway + DynamoDB |
| **Event Bus** | Distribution événements | SQS / Kafka |
| **Processing** | Traitement asynchrone | Lambda / ECS |
| **Storage** | Stockage durable | S3 + DynamoDB |
| **Analytics** | Requêtes et rapports | Glue + Athena |
| **Monitoring** | Observabilité | CloudWatch + Alarms |

---

## Voir aussi

- 🔗 [Diagrammes détaillés](diagrams.md)
- 🔐 [Architecture sécurité](security.md)
- 📊 [Détails techniques](technical.md)
