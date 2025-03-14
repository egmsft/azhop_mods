import {
  to = azurerm_public_ip.pip_natgateway[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/publicIPAddresses/pip-${local.nat_gateway_name}"
}

import {
  to = azurerm_nat_gateway.natgateway[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/natGateways/${local.nat_gateway_name}"
}

import {
  to =  azurerm_nat_gateway_public_ip_association.natgateway_pip_association[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/natGateways/${local.nat_gateway_name}|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/publicIPAddresses/pip-${local.nat_gateway_name}"
}