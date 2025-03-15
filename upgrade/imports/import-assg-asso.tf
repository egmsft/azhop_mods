import {
  to = azurerm_network_interface_application_security_group_association.ad-asg-asso["asg-ad-client"]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ad_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ad-client"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.scheduler-asg-asso["asg-ssh"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.scheduler_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ssh"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.scheduler-asg-asso["asg-sched"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.scheduler_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-sched"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.scheduler-asg-asso["asg-nfs-client"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.scheduler_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-nfs-client"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.scheduler-asg-asso["asg-cyclecloud-client"]  
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.scheduler_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-cyclecloud-client"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.scheduler-asg-asso["asg-ad-client"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.scheduler_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ad-client"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ondemand-asg-asso["asg-ssh"]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ondemand_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ssh"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ondemand-asg-asso["asg-sched"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ondemand_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-sched"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ondemand-asg-asso["asg-nfs-client"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ondemand_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-nfs-client"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ondemand-asg-asso["asg-cyclecloud-client"]  
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ondemand_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-cyclecloud-client"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ondemand-asg-asso["asg-ad-client"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ondemand_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ad-client"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ondemand-asg-asso["asg-ondemand"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ondemand_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ondemand"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.jumpbox-asg-asso["asg-ssh"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.jumpbox_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ssh"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.jumpbox-asg-asso["asg-jumpbox"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.jumpbox_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-jumpbox"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ccportal-asg-asso["asg-ssh"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ccportal_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ssh"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ccportal-asg-asso["asg-cyclecloud"]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ccportal_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-cyclecloud"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ccportal-asg-asso["asg-ad-client"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ccportal_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ad-client"]}"
}

import {
  to =  azurerm_network_interface_application_security_group_association.ad-asg-asso["asg-rdp"] 
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ad_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-rdp"]}"
}

import {
  to = azurerm_network_interface_application_security_group_association.ad-asg-asso["asg-ad"]
  id = "${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/networkInterfaces/${local.ad_name}-nic|${data.azurerm_subscription.primary.id}/resourceGroups/${local.resource_group}/providers/Microsoft.Network/applicationSecurityGroups/${local.asgs["asg-ad"]}"
}