# generate the storage account names based on naming convention
module "storage_account_name" {
  #source              = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/naming_convention"
  source              = "./../naming_convention"
  for_each            = { for idx, sa in var.storage_accounts : idx => sa }
  storage_description = each.value.description
  environment         = var.environment
  type                = "storage_account"
}

# create's storage accounts
resource "azurerm_storage_account" "storage_account" {
  for_each                          = { for idx, sa in var.storage_accounts : idx => sa }
  name                              = module.storage_account_name[each.key].name
  resource_group_name               = each.value.rg_name
  location                          = var.location
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.replication
  enable_https_traffic_only         = true
  min_tls_version                   = "TLS1_2"
  infrastructure_encryption_enabled = each.value.encrypt_infra
  allow_nested_items_to_be_public   = each.value.public_nested
  shared_access_key_enabled         = each.value.shared_access_key
  public_network_access_enabled     = each.value.public_access

  blob_properties {
    delete_retention_policy {
      days = each.value.delete_retention
    }
    restore_policy {
      days = each.value.restore
    }
    #  A restore_policy block as defined below. This must be used together with delete_retention_policy set, versioning_enabled and change_feed_enabled set to true.
    change_feed_enabled = true #`change_feed_enabled` must be `true` when `restore_policy` is set
    versioning_enabled  = true #`versioning_enabled` must be `true` when `restore_policy` is set
  }

  network_rules {
    default_action             = "Deny"
    ip_rules                   = each.value.allowed_pips
    virtual_network_subnet_ids = each.value.allowed_snet_ids
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      customer_managed_key,
      tags
    ]
  }
}

# create's storage account system assigned managed identity's role on key vault to encrypet the storage data
module "role_assignment" {
  #source   = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/role_assignment"
  source   = "./../role_assignment"
  for_each = { for idx, sa in var.storage_accounts : idx => sa }
  assignments = [
    {
      scope        = each.value.kv_id
      role_name    = "Key Vault Crypto Service Encryption User"
      principal_id = azurerm_storage_account.storage_account[each.key].identity.0.principal_id
    }
  ]
  depends_on = [azurerm_storage_account.storage_account]
}

# configure's storage accont cmk
resource "azurerm_storage_account_customer_managed_key" "cmk" {
  for_each           = { for idx, sa in var.storage_accounts : idx => sa }
  storage_account_id = azurerm_storage_account.storage_account[each.key].id
  key_vault_id       = each.value.kv_id
  key_name           = each.value.kv_key_name
  depends_on         = [azurerm_storage_account.storage_account, module.role_assignment]
}

# create's storage account's containers
resource "azurerm_storage_container" "storage_container" {
  for_each              = { for container in local.storages : "${container.storage_key}.${container.container_key}" => container }
  name                  = each.value.container_name
  storage_account_name  = azurerm_storage_account.storage_account[each.value.storage_key].name
  container_access_type = "private"
}

# create's storage account's private endpoint
module "private_endpoint" {
  #source                = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/private_endpoint"
  source                = "./../private_endpoint"
  for_each              = { for idx, sa in var.storage_accounts : idx => sa }
  workload              = "sa-${each.value.description}"
  environment           = var.environment
  location              = var.location
  rg_name               = each.value.rg_name
  snet_id               = var.pe_snet_id
  connected_resource_id = azurerm_storage_account.storage_account[each.key].id
  subresource           = "blob"
  zone_name             = "privatelink.blob.core.windows.net"
  zone_id               = var.pe_zone_id
  resource_number       = each.key + 1
  depends_on            = [azurerm_storage_account.storage_account, azurerm_storage_container.storage_container]
}
