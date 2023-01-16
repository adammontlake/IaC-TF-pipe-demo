GitHub Repo (Open source!)
Create folder in repo
	main <- this is where you put all the terraform files
	.github/workflows <- This is where we will place the actions file
Add terraform files into repo
	Copy from resources in our repo
Add action file into repo
	Copy from resources in our repo
Azure account
	Create Resource Group 
	Create Storage account
		create container with name: (to hold Terraform state)
Service Principal (for TF to deploy)
	with permissions: "contributor" on the Azure account
	Generate secret for the SP
Add these secrets to github secret
	ARM_CLIENT_ID 
	ARM_CLIENT_SECRET 
	ARM_TENANT_ID 
	ARM_SUBSCRIPTION_ID 
	RESOURCE_GROUP 
	STORAGE_ACCOUNT 
	CONTAINER_NAME 
