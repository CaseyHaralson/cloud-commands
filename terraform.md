# Terraform

https://developer.hashicorp.com/terraform/cli/commands

Terraform Registry: https://registry.terraform.io/

Google Provider: https://registry.terraform.io/providers/hashicorp/google/latest/docs

## Commands

Prepare the working directory for other commands:

```
terraform init
```

If you need to migrate state from one backend to anther:

```
terraform init -migrate-state
```

Refresh the backend state with the current state and display the state:

```
terraform refresh

terraform show
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

Mark a resource as not fully functional so it will be destroyed and recreated on next apply:

```
terraform taint [resource-path-and-name]
```

Destroy the current state infrastructure (DESTROYS EVERYTHING):

```
terraform destroy
```

## Import State

Note: backup any existing .terraform and terraform.tfstate files before proceeding.

Importing state requires a provider to be setup, an importing of resources, loading the resources to configuration files, and then applying the configuration which will give Terraform control over the objects.

1. Create a provider configuration (not shown here) and initialize the workspace.

```
terraform init
```

2. Import the existing resource.

```
terraform import [terraform-resource-path-and-name] [resource-id]
```

3. Verify that the resource has been added to the state.

```
terraform show
```

4. Create a configuration file for the resource. Either individually select the required attributes into a configuration file (not shown here) or output the current state into a configuration file.

```
terraform show -no-color > [file].ts
```

5. Check the configuration file and keep modifying it till it is correct. Run the plan command and check the output to get hints on what to change.

```
terraform plan
```

6. Once the configuration file is correct, apply the configuration to give control to Terraform.

```
terraform apply
```
