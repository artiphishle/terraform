# Edu Terraform

## Commands

In general you create a `main.tf` file, call `init` & `apply`. Done. Then `destroy` to remove everything again.

### [terraform init](https://developer.hashicorp.com/terraform/cli/commands/init)

"The terraform init command initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control."

### [terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan)

"The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure."

### [terraform fmt](https://developer.hashicorp.com/terraform/cli/commands/fmt)

"The terraform fmt command is used to rewrite Terraform configuration files to a canonical format and style. This command applies a subset of the Terraform language style conventions, along with other minor adjustments for readability."

### [terraform validate](https://developer.hashicorp.com/terraform/cli/commands/validate)

"The terraform validate command validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc."

### [terraform apply](https://developer.hashicorp.com/terraform/cli/commands/apply)

"The terraform apply command executes the actions proposed in a Terraform plan."

### [terraform destroy](https://developer.hashicorp.com/terraform/cli/commands/destroy)

"The terraform destroy command is a convenient way to destroy all remote objects managed by a particular Terraform configuration."