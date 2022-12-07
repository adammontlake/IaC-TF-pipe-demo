# Demo Terraform module for resource naming convention

## Description
The module will generate the base string for resource name based on common guidelines and standards.  
<br />

## Naming convention 
The module will output with the following conventaion `<env_prefix>-<service_name>-<location_short>`  
<br />

## Example
 **main.tf - file usage**  
 
```terraform
module "naming" {
  source      = "git::https://github.com/IaC-TF-pipe-demo/terraform-modules.git//general/naming?ref=general-naming-v1.0"
  location    = var.location
  environment = var.environment
  servicename = var.servicename
}
```

For exmaple if I am creating redis module I will call this module with the following variables:  
```terraform
location    = "west europe"  
servicename = "example-api-rds"  
environment = "production"  
```
To get the output: `${module.naming.full_name}`  
The output will be: `prod-example-api-rds-we`  
<br />

## Variables
### Required Variables
```yaml
# The region that the service will be deployed on 
location -
    type: string
    input: west europe / north europe / etc... 

# the environment short name that will be used for the resource name prefix 
environment -
    type: string
    input: integration / staging / production / preprod  / prodtesting / pci

# the name of the service for example: sts-b-api/sts-b-api-rds
servicename -
    type: string
```

### Output
```yaml
# will privede the short location, for example "West Europe" will convert to > we
location_short

# will provied the short enviorment, for example: "Production" will convert to > prod
env

# full name which containe the location_short, env, and the name from the caller module
full_name
```
### Local variable 
```yaml
# convert "West Europe" > we
location_short 
  
# create short location naming convention  
env
```
<br />

# Change log
