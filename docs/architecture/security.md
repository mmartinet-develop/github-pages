# 🔐 Sécurité & IAM

## Principes

### Least Privilege
- Chaque role a les **permissions minimales** requises
- Refus par défaut, autoriser explicitement
- Audit trail complet via CloudTrail

### Isolation
- **VPC isolation** : Un VPC par Team
- **IAM isolation** : Un role par fonction
- **Encryption** : At-rest et in-transit obligatoire

### Defense in Depth
```
Layer 1: AWS Account isolation
Layer 2: VPC + Security Groups
Layer 3: IAM policies
Layer 4: Encryption
Layer 5: Monitoring & Alerting
```

---

## IAM Structure

### Role - Lambda Execution

```hcl
resource "aws_iam_role" "lambda_execution" {
  name = "lambda-execution-team-a"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Inline policy pour minimum permissions
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda-policy"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = [
          aws_dynamodb_table.events.arn,
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
}
```

### Roles par environnement

| Role | Permissions | Utilisateurs |
|------|-------------|--------------|
| **Developer** | Read + Deploy lambda | Engineers |
| **DevOps** | Full AWS access (with MFA) | Infrastructure team |
| **Auditor** | CloudTrail + read-only | Compliance team |

---

## Encryption

### At Rest
- **DynamoDB** : Encryption SSE-KMS
- **S3** : Encryption SSE-S3 ou SSE-KMS
- **RDS** : Encryption enabled
- **EBS & Snapshots** : Encryption enabled

### In Transit
- **TLS 1.2+** : API Gateway → Lambda → DynamoDB
- **VPC Endpoints** : Pour AWS services internes
- **mTLS** : Pour Kafka inter-service

---

## Audit & Monitoring

### CloudTrail
```json
{
  "cloudtrail": {
    "enabled": true,
    "multi_region": true,
    "s3_bucket": "central-logs",
    "kms_key_id": "arn:aws:kms:..."
  }
}
```

### GuardDuty
- Threat detection activée
- Alertes SNS en real-time
- Dashboard CloudWatch

### Logging
- All API calls → CloudTrail
- Application logs → CloudWatch Logs
- Access logs → ALB/API Gateway CloudWatch

---

## Compliance

### Standards applicables
- ✅ **AWS Well-Architected Framework** : Security pillar
- ✅ **CIS AWS Foundations Benchmark**
- ✅ **OWASP Top 10** (si applicable)
- ✅ **Data Privacy** : GDPR compliance pour EU

### Checklist sécurité

- [ ] CloudTrail activé multi-région
- [ ] MFA enforced pour console access
- [ ] IMDSv2 obligatoire (EC2)
- [ ] Encryption at-rest pour tous les stores
- [ ] TLS 1.2+ pour toutes communications
- [ ] VPC Flow Logs enabled
- [ ] GuardDuty enabled
- [ ] Config Rules pour conformité

---

## Secrets Management

```hcl
# AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "prod/database/password"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

# Usage dans Lambda
import json
from botocore.session import get_session

def get_secret(secret_name):
    session = get_session()
    client = session.create_client('secretsmanager')
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response['SecretString'])
```

---

## Voir aussi

- [Organisation AWS](organization.md)
- [Réseau & VPC](network.md)
- [Détails techniques](technical.md)
