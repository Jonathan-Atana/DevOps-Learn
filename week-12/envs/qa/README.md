<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ../../../modules/compute/ec2 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | S3 bucket name for storing Terraform state | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment for the resources, e.g., dev, staging, prod | `string` | `"qa"` | no |
| <a name="input_project_prefix"></a> [project\_prefix](#input\_project\_prefix) | Prefix to use for all my resources for easy identification | `string` | `"app"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy resources in | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public-ip"></a> [public-ip](#output\_public-ip) | Public IP address of the EC2 instance |
| <a name="output_ssh-command"></a> [ssh-command](#output\_ssh-command) | SSH command to connect to the EC2 instance |
<!-- END_TF_DOCS -->
