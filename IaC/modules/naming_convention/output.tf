# Output will privede the short location, for example "West Europe" will convert to > we
output "location_short" {
  value = local.location_short
}

# Output will provied the short enviorment, for example: "Production" will convert to > prod
output "env" {
  value = local.env
}

# Output include the full name which containe the location_short, env, and the name from the caller module
output "full_name" {
  value = lower("${local.env}-${var.servicename}-${local.location_short}")
}

# Output name with only alpha numeric to comply with resources naming limits
output "name_alphanum" {
  value = lower("${local.env}${var.servicename}${local.location_short}")
}