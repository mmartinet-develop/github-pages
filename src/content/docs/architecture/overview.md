---
title: Vue d'ensemble
description: Vue d'ensemble de l'architecture
---

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

## 🔗 Documentation associée

- [Diagrammes](diagrams.md)
- [Architecture réseau](network.md)
- [Sécurité](security.md)
- [Spécifications techniques](technical.md)
