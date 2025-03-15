
import {
  to = azurerm_storage_account.azhop
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Storage/storageAccounts/${local.storage_account_name}"
}

import {
  to = azurerm_shared_image_gallery.sig[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Compute/galleries/${local.sig_name}"
}

import {
  to = azurerm_key_vault.azhop
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.KeyVault/vaults/${local.key_vault_name}"
}

# Uncomment if you are using the same identity that was used to create the deployment
#import {
#  to =  azurerm_key_vault_access_policy.admin                                                                                                               
#  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.KeyVault/vaults/${local.key_vault_name}/objectId/${local.logged_user_objectId}"
#}