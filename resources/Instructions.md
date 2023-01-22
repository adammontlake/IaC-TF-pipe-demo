IaC - instructions
============
1. Create a GitHub Repo (Must be: **Public** - Open source!)
2. Create the following file structure in your new repo
   * main/terraform.tf <- this is where you put all the terraform files
   * .github/workflows/action.yml <- This is where we will place the actions file
3. Add terraform files into repo
   * Copy from resources in our repo
4. Add action file into repo
   * Copy from resources in our repo
5. Azure account
   * Create Resource Group 
     * Resource Group name: "IaC_pipelines_rg" (to hold all the new resources)
   * Create Storage account
     * Storage account name: tfstorage$RAND
     * In the storage account, create a container with the name: tfstate (to hold Terraform state)
6. Service Principal (for TF to deploy)  **with permissions: "contributor" on the Azure account**
    * Generate secret for the SP
7. Add these secrets to github secret
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
