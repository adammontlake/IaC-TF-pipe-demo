locals {
  storages = flatten([
    for storage_key, storage in var.storage_accounts : [
      for container_key, container in storage.containers : {
        storage_key    = storage_key
        container_key  = container_key
        container_name = container
      }
    ]
  ])
}
