# Scalable & Secure Multi-Tier AWS Architecture (Root Module)

## Overview

This Terraform root module provisions a scalable, secure, and highly available multi-tier application infrastructure on AWS. It leverages modular design for maintainability and reusability, following best practices for tagging, namespacing, monitoring, and private connectivity.

**Key Features:**

- Modularized resources: VPC endpoints, EC2 (bastion, ASG), RDS, ELB, S3, IAM, CloudWatch, SNS, Security Groups
- Consistent tagging and namespacing
- Monitoring and alerting with CloudWatch and SNS
- Private connectivity via VPC endpoints
- Secure, least-privilege IAM roles

---

## Architecture Diagram

See `architecture.drawio` for a visual representation of the deployed architecture.

---

## Module Structure

- `main.tf` — Root orchestration, module wiring
- `variables.tf` — Input variables (environment, namespace, etc.)
- `outputs.tf` — Root outputs
- `terraform.tfvars` — Example variable values
- `modules/` — All submodules (see below)

### Included Modules

- `app_asg` — Application Auto Scaling Group
- `cloudwatch` — CloudWatch alarms, metrics, log groups
- `ec2` — Bastion host(s)
- `elb` — Elastic Load Balancer
- `iam_role` — IAM roles and policies
- `rds` — Relational Database Service
- `s3` — S3 buckets (app, logs, etc.)
- `security_group` — Security groups for all tiers
- `sns` — SNS topics for alerting
- `vpc_endpoint` — VPC endpoints for private AWS service access

---

## Usage

1. **Configure variables** in `terraform.tfvars` or via CLI/environment.
2. **Initialize**: `terraform init`
3. **Plan**: `terraform plan -out=tfplan`
4. **Apply**: `terraform apply tfplan`

---

## Input Variables

| Name        | Description                       | Type   | Example |
| ----------- | --------------------------------- | ------ | ------- |
| environment | Deployment environment (dev/prod) | string | "dev"   |
| namespace   | Project or team namespace         | string | "myapp" |
| ...         | Module-specific variables         |        |         |

See `variables.tf` and each module's README for details.

---

## Outputs

- All key resource IDs, ARNs, endpoints, and connection details are output for integration and reference.
- See `outputs.tf` and each module's README for specifics.

---

## Tagging & Namespacing

- All resources are tagged with `environment`, `namespace`, and standard tags via provider `default_tags`.
- Ensures cost allocation, traceability, and resource hygiene.

---

## Monitoring & Alerting

- **CloudWatch**: Alarms for EC2, RDS, ELB, etc.
- **SNS**: Notification topics for alerting (e.g., email, SMS)
- **CloudWatch Logs**: Optional log group/stream integration for EC2/app logs
- See `modules/cloudwatch/README.md` for advanced monitoring setup.

---

## Security Best Practices

- Principle of least privilege for IAM roles
- Security groups restrict traffic by tier
- No public RDS or S3 access
- Bastion host for admin access only
- VPC endpoints for private AWS service access

---

## Private Connectivity

- VPC endpoints (S3, DynamoDB, CloudWatch, SNS) for private, secure AWS API access
- See `modules/vpc_endpoint/README.md` for details

---

## Customization

- Add/modify modules as needed for your use case
- Override variables in `terraform.tfvars` or via CLI
- Extend monitoring, logging, or security as required

---

## Maintenance

- Keep Terraform and AWS provider versions up to date
- Review module READMEs for usage and input/output details
- Remove obsolete modules/files as your architecture evolves

---

## References

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform.io/docs/language/index.html)

---

## Authors & Support

- Project maintained by your DevOps/Cloud team
- For issues, open a ticket or contact the maintainer

---

## License

MIT (or your organization’s preferred license)
