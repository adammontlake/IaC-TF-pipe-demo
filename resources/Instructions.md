IaC - instructions
============
1. Create a GitHub Repo (Must be: **Public** - Open source!)
   * Select the owner as yourself
   * Give the repo a name
   * Select **public**
   * **Do not** add readme or GitIgnore at this stage
   * Press "create repository"
   * In the "quick setup" page, select **import code** ![import screenshot](https://github.com/adammontlake/IaC-TF-pipe-demo/blob/add_resources/resources/import_code.png)
   * Use the following repo to import: https://github.com/adammontlake/IaCPipelineStructure
6. Azure account
   * Create Resource Group 
     * Resource Group name: "IaC_pipelines_rg" (to hold all the new resources)
   * Create Storage account
     * Storage account name: tfstorage${RANDOM_STRING}
     * In the storage account, create a container with the name: tfstate (to hold Terraform state)
7. [Service Principal](https://learn.microsoft.com/en-us/azure/purview/create-service-principal-azure) (for TF to deploy)  **with permissions: "contributor"**
    * Create a service principal for automatic deployment
    * Generate a secret 
8. Add these secrets to github secret
    * Settings  ->  Secrets and Variables  ->  Actions  ->  New repository secret
~~~
    * ARM_CLIENT_ID 
    * ARM_CLIENT_SECRET 
    * ARM_TENANT_ID 
    * ARM_SUBSCRIPTION_ID 
    * RESOURCE_GROUP
    * STORAGE_ACCOUNT
    * CONTAINER_NAME
~~~
