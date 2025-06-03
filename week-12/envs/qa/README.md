<!-- BEGIN_TF_DOCS -->

## Note:

I made use of my custom modules in this project. See ...

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name                                         | Source                                             | Version |
| -------------------------------------------- | -------------------------------------------------- | ------- |
| <a name="module_ec2"></a> [ec2](#module_ec2) | ../../../../../Learn/Terraform/modules/compute/ec2 | n/a     |

## Resources

No resources.

## Inputs

| Name                                                                        | Description                                                | Type     | Default       | Required |
| --------------------------------------------------------------------------- | ---------------------------------------------------------- | -------- | ------------- | :------: |
| <a name="input_bucket"></a> [bucket](#input_bucket)                         | S3 bucket name for storing Terraform state                 | `string` | n/a           |   yes    |
| <a name="input_env"></a> [env](#input_env)                                  | Environment for the resources, e.g., dev, staging, prod    | `string` | `"qa"`        |    no    |
| <a name="input_project_prefix"></a> [project_prefix](#input_project_prefix) | Prefix to use for all my resources for easy identification | `string` | `"app"`       |    no    |
| <a name="input_region"></a> [region](#input_region)                         | AWS region to deploy resources in                          | `string` | `"us-east-1"` |    no    |

## Outputs

| Name                                                                 | Description                                |
| -------------------------------------------------------------------- | ------------------------------------------ |
| <a name="output_public-ip"></a> [public-ip](#output_public-ip)       | Public IP address of the EC2 instance      |
| <a name="output_ssh-command"></a> [ssh-command](#output_ssh-command) | SSH command to connect to the EC2 instance |

<!-- END_TF_DOCS -->
