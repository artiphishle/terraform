# Terraform

Some basic terraform examples.


## Quickstart OSX

### Install Terraform
```bash
brew tap hashicorp/tap
brew install terraform

terraform -install-autocomplete
```

### Basic Commands

🔗 [Terraform commands](./COMMANDS.md)

## Examples

You find the working configs in the [examples/](./examples) directory.

### 1. Docker with running NginX

🔗 [Install Docker Desktop](https://docs.docker.com/desktop/install/mac-install/)

```bash
cd examples/nginx-with-docker

terraform init
terraform apply
# Check localhost:8000 for running nginx
terraform destroy
```

### 2. AWS t2-micro

Prerequisite: [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```bash
# Go to AWS IAM Dashboard & 'create access key', add:
aws configure
cd examples/aws-t2-micro

terraform init
terraform apply
# Check AWS account for running t2-micro (EC2 service)
terraform destroy
```

### 3. Local file and variables

How to create variables and local files, check out the example.

### 4. VPC

VPC with a private and public subnet, nat gateway & internet gateway

#### Result

![AWS Result 'VPC'](examples/vpc/VPC.png)

## Troubleshoot

### Error on `source ~/.zshrc`

Verify `~/.zshrc` command for this entry:

```bash
autoload -Uz compinit && compinit # This line was missing
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
```

### AWS refuses connection on port 53

My `/etc/resolv.conf` was missing, so I've linked it again:

```bash
# Requires root privilegues
ln -s /var/run/resolv.conf /etc/resolv.conf
```
