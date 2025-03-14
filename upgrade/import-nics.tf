import {
  to = azurerm_network_interface.ad-nic[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ad_name}-nic"
}

import {
  to = azurerm_network_interface.scheduler-nic
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.scheduler_name}-nic"
}

import {
  to = azurerm_network_interface.ondemand-nic[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ondemand_name}-nic"
}

import {
  to = azurerm_network_interface.jumpbox-nic[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.jumpbox_name}-nic"
}

import {
  to = azurerm_network_interface.ccportal-nic
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ccportal_name}-nic"
}