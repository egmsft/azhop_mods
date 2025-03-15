import {
  to = azurerm_private_dns_zone.azhop_private_dns[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}"
}

import {
  to =  azurerm_private_dns_zone_virtual_network_link.azhop_dns_link[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/virtualNetworkLinks/az-hop"
}

import {
  to = azurerm_private_dns_srv_record.ldapdefault-first-site-name_sitesgc_msdcs[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_ldap.default-first-site-name._sites.gc._msdcs"
}

import {
  to = azurerm_private_dns_srv_record.ldapdefault-first-site-name_sitesdc_msdcs[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_ldap.default-first-site-name._sites.dc._msdcs"
}

import {
  to = azurerm_private_dns_srv_record.ldap_tcppdc_msdcs[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_ldap._tcp.pdc._msdcs"
}

import {
  to = azurerm_private_dns_srv_record.ldap_tcpdc_msdcs[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_ldap._tcp.dc._msdcs"
}

import {
  to = azurerm_private_dns_srv_record.ldap_tcp_gc_msdcs[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_ldap._tcp.gc._msdcs"
}

import {
  to = azurerm_private_dns_srv_record.ldap_tcp[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_ldap._tcp"
}

import {
  to =  azurerm_private_dns_srv_record.kpasswd_udp[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_kpasswd._udp"
}

import {
  to =  azurerm_private_dns_srv_record.kpasswd_tcp[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_kpasswd._tcp"
}

import {
  to = azurerm_private_dns_srv_record.kerberosdefault-first-site-name_sitesdc_msdcs[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_kerberos.default-first-site-name._sites.dc._msdcs"
}

import {
  to = azurerm_private_dns_srv_record.kerberos_udp[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_kerberos._udp"
}

import {
  to = azurerm_private_dns_srv_record.kerberos_tcpdc_msdcs[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_kerberos._tcp.dc._msdcs"
}

import {
  to = azurerm_private_dns_srv_record.kerberos_tcp[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_kerberos._tcp"
}

import {
  to = azurerm_private_dns_srv_record.gc_tcp[0]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/SRV/_gc._tcp"
}

import {
  to = azurerm_private_dns_a_record.ad[0] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}/A/ad"
}