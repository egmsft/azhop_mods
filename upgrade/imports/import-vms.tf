import {
  to = azurerm_windows_virtual_machine.ad[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Compute/virtualMachines/${local.ad_name}"
}
