# 🌐 Réseau & VPC

## Architecture réseau

### VPC Layout

Chaque Team dispose d'une VPC isolée avec structure standard :

```
VPC (10.x.0.0/16)
├── Public Subnets (10.x.1.0/24, 10.x.2.0/24)
│   ├── NAT Gateway
│   ├── ALB (si nécessaire)
│   └── API Gateway endpoints
├── Private Subnets (10.x.11.0/24, 10.x.12.0/24)
│   ├── Lambda functions
│   ├── RDS (si applicable)
│   └── Kafka brokers
└── Database Subnets (10.x.21.0/24, 10.x.22.0/24)
    └── DynamoDB (managed, pas d'EC2)
```

### Adressage IP

| Composant | CIDR | AZ |
|-----------|------|-----|
| VPC Team A | 10.1.0.0/16 | Multi-AZ |
| VPC Team B | 10.2.0.0/16 | Multi-AZ |
| VPC Team C | 10.3.0.0/16 | Multi-AZ |
| VPC Shared | 10.0.0.0/16 | Multi-AZ |

---

## Communication inter-VPC

### VPC Lattice (recommandé)
- [x] Service-to-service discovery
- [x] Load balancing automatique
- [x] Sécurité au niveau service
- [x] Monitoring intégré

Configuration:
```hcl
# Service Network Lattice
resource "aws_vpclattice_service_network" "main" {
  name = "mini-lab-network"
}

# Attachment des VPCs
resource "aws_vpclattice_service_network_vpc_association" "teams" {
  for_each           = var.team_vpcs
  service_network_id = aws_vpclattice_service_network.main.id
  vpc_id             = each.value.vpc_id
}
```

### Sécurité réseau

**Security Groups par workload** :

| SG | Rules | Ports |
|----|-------|-------|
| Lambda SG | Ingress from ALB | 3000-3999 |
| RDS SG | Ingress from Lambda | 5432 (PostgreSQL) |
| Kafka SG | Ingress from VPC Lattice | 9092 |
| API Gateway | All egress allowed | N/A |

---

## DNS & Service Discovery

- **Route53** : Zones privées par VPC
- **Lattice DNS** : `service.team-a.vpc-lattice.us-east-1.on.aws`
- **Secrets Manager** : Credentials centralisés

---

## NAT & Egress

```
Lambda (Private) → NAT Gateway (Public) → Internet
```

Cost optimization:
- NAT Gateway : €32/mois en us-east-1
- Considérer **VPC Endpoints** pour AWS services (S3, DynamoDB, etc.)

---

## Voir aussi

- [Organisation AWS](organization.md)
- [Détails techniques](technical.md)
- [Sécurité & IAM](security.md)
