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
2. Azure account
   * Create Resource Group 
     * Resource Group name: "IaC_pipelines_rg" (to hold all the new resources)
   * Create Storage account
     * Storage account name: tfstorage${RANDOM_STRING}
     * In the storage account, create a container with the name: tfstate (to hold Terraform state)
       * Public access level = Private
3. [Service Principal](https://learn.microsoft.com/en-us/azure/purview/create-service-principal-azure) (for TF to deploy)  **with permissions: "contributor"**
    * Create a service principal for automatic deployment
      *  Name = terraform_runner_sp
    * Generate a secret 
      * Set expiry date to: Monday 30th Jan 2023
    * Make sure you give the correct permissions to the SP - Recommended: "Contributor" on the subscription (to avoid issues) and remember to delete later :) 
4. Generate GutHub PAT (personal access token) - this will be used to post comments to PR during the pipeline
    * Your Profile (picture on top right)  -> Settings -> Developer Settings -> Personal Access Tokens -> Tokens (classic) -> Generate new token (classic) -> give it a name and provide it ![permissions](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal) on repo -> copy the token for later
5. Add all secrets to github secret
    * Settings  ->  Secrets and Variables  ->  Actions  ->  New repository secret
![repo settings screenshot](https://github.com/adammontlake/IaC-TF-pipe-demo/blob/add_resources/resources/repo_settings.png)
~~~
    * ARM_CLIENT_ID 
    * ARM_CLIENT_SECRET 
    * ARM_TENANT_ID 
    * ARM_SUBSCRIPTION_ID 
    * RESOURCE_GROUP
    * STORAGE_ACCOUNT
    * CONTAINER_NAME
    * GH_TOKEN
~~~
