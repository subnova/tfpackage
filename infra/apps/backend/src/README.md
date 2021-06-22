# Backend Deployment

Terraform code to deploy our backend image to Azure. The Terraform code will be
packaged into a tar along with the Terraform binary and Docker image to deploy.

The infra pipeline can unpack this bundle and execute Terraform (init and apply)
to deploy the Backend application.

Pre-requisites for running the deployment:
* A Posix compatible shell
* `jq`
* `docker`
* Azure resource group
* Azure container registry

The following Terraform variables must be set:
* `env` - the name of the environment to deploy to, this will be used to ensure resources have unique names
* `rg_name` - the name of the resource group to use
* `rg_location` - the location of the resource group to use
* `acr_name` - the name of the Azure container registry to use (must be within the resource group)
