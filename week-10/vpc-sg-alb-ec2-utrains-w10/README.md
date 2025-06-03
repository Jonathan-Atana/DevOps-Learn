<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.98.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.98.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.server](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/resources/instance) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/resources/lb) | resource |
| [aws_lb_listener.alb-listener](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.sg1](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/resources/security_group) | resource |
| [aws_security_group.sg2](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/resources/security_group) | resource |
| [aws_ami.main](https://registry.terraform.io/providers/hashicorp/aws/5.98.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ami_names"></a> [aws\_ami\_names](#input\_aws\_ami\_names) | List of names of the AWS AMI to use | `list(string)` | n/a | yes |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | AWS S3 bucket name | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Project Environment | `string` | `"Dev"` | no |
| <a name="input_http_port"></a> [http\_port](#input\_http\_port) | Default port for http traffic | `number` | `80` | no |
| <a name="input_https_port"></a> [https\_port](#input\_https\_port) | Default port for https traffic | `number` | `443` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of EC2 instance to launch | `string` | n/a | yes |
| <a name="input_package_manager"></a> [package\_manager](#input\_package\_manager) | Package manager used for user data | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy infrastructure | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb-dns"></a> [alb-dns](#output\_alb-dns) | n/a |
<!-- END_TF_DOCS -->