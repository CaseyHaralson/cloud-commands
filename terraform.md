# Terraform

https://developer.hashicorp.com/terraform/cli/commands

Terraform Registry: https://registry.terraform.io/

Google Provider: https://registry.terraform.io/providers/hashicorp/google/latest/docs

## Commands

Prepare the working directory for other commands:

```
terraform init
```

Create an execution plan with the current directory's .tf files:

```
terraform plan
terraform plan -out [plan-filename]
```

Apply the current directory's .tf files:

```
terraform apply
terraform apply "[plan-filename]"
```

Inspect the current state:

```
terraform show
```

Destroy the current state infrastructure:

```
terraform destroy
```

Mark a resource as not fully functional so it will be destroyed and recreated on next apply:

```
terraform taint [resource-path-and-name]
```
