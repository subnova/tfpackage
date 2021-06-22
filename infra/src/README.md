# Base Infrastructure Deployment

Terraform code to deploy the base infrastructure required by the project. This
will provision an Azure Resource Group and Azure Container Registry that can be
used by other components. The Terraform code will be packaged into a tar along
with the Terraform binary.

The infra pipeline can unpack this bundle and execute Terraform (init and apply)
to deploy the Base infrastructure.

The following Terraform variables must be set:
* `env` - the name of the environment to deploy to, this will be used to ensure resources have unique names
