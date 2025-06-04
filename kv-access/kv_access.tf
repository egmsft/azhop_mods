terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.111.0"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data azurerm_key_vault existing_kv {
    name         = var.kv_name
    resource_group_name = var.kv_rg_name
}

resource "azurerm_key_vault_access_policy" "admin" {
  key_vault_id = data.azurerm_key_vault.existing_kv.id
  tenant_id    = var.tenant_id
  object_id    = var.mi_obj_id

  secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
      "Purge",
      "Recover",
      "Restore"
    ]
}


