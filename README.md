# terraform_setup_azure
This terraform script is used to setup Unity Metastore, assign workspaces, create storage credentials and create external locations.<br>
This script assumes that prerequisites such as storage account,storage containers etc are already created. <br>
Current config stores the terraform state on adls. Please amend `backend` section in providers.tf file as per user's requirement. <br>

It consists of following sections: <br>
- meta-setup
- env-setup

## meta-setup
This section is expected to be executed once to setup unity metatsore<br>
This section will create access connector and assign 'Storage Blob Data Contributor' role to access connector on meta account provided user executing the script has the required accesses.<br>
If access connector already exists then it can be provided by setting following variables:<br>
`existing_access_connector_id ="<access-connector-resource-id>"` <br>
`access_connector_exist = true` <br>
Please refer to  variables file and provide required values. User can refer to meta.tfvars file for the sample values

## env-setup
This section is expected to be executed once per each environment<br>
This section will assign workspaces to the metastore, create storage credential for env and create external locations.<br>
Please efer to variables file and required values. User can refer to dev.tfvars file for the sample values
## Useful terraform commands
`terraform init` - To initialize terraform config <br>
`terraform validate` - To validate terraform config <br>
`terraform workspace new <workspace-name> ` - To create new workspace <br>
*It is recommended to create one workspace per env. It helps to keep the states of workspaces isolated* <br>
`terraform plan --var-file=<path-of-var-file>` - To run terraform plan <br>
`terraform apply --var-file=<path-of-var-file>` - To deploy resources <br>
`terraform destroy --var-file=<path-of-var-file>` - To destroy resources <br>
`terraform refresh --var-file=<path-of-var-file>` - To refresh state  <br>
