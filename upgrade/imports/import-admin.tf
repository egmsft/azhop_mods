import {
    to = azurerm_key_vault_secret.admin_password
    id = "<enter link to secret identifier>"
}

import {
  to = azurerm_key_vault_secret.admin_ssh_private
  id = "<enter link to secret identifier>"
}

import {
  to = azurerm_key_vault_secret.admin_ssh_public
  id = "<enter link to secret identifier>"
}

# Requires block to ignore changes for postfix and password attribute
# example block below for postfix: 
#    lifecycle {
#    ignore_changes = [
#      length,
#      special,
#      upper,
#      lower,
#      numeric
#    ]
#  }
#
# example block below for password: 
#    lifecycle {
#    ignore_changes = [
#      length,
#      special,
#      min_lower,
#      min_upper,
#      min_numeric,
#      override_special
#    ]
#  }
#

import {
  to =  random_string.resource_postfix                                                                                                               
  id = "<enter resource postfix>"
}

data azurerm_key_vault existing_kv {
    name         = local.key_vault_name
    resource_group_name = local.resource_group
}

data azurerm_key_vault_secret existing_admin_password {
  name         = "hpcadmin-password"
  key_vault_id = data.azurerm_key_vault.existing_kv.id
}

import {
    to = random_password.password
    id = data.azurerm_key_vault_secret.existing_admin_password.value
}

