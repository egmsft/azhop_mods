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

data "azurerm_resource_group" "vnet_rg" {
  name = var.vnet.rg
}

data "azurerm_virtual_network" "vnet" {
    name                = var.vnet.name
    resource_group_name = var.vnet.rg
}

data "azurerm_subnet" "deployer_subnet" {
  name                 = var.vnet.subnet 
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

resource "azurerm_network_interface" "deployer_nic" {
  name                = "${var.name_prefix}-nic"
  location            = data.azurerm_virtual_network.vnet.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "deployer-nic-ip"
    subnet_id                     = data.azurerm_subnet.deployer_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "deployer" {
  name                  = "${var.name_prefix}-vm"
  location              = data.azurerm_virtual_network.vnet.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.deployer_nic.id]
  size               = var.vm_size
  
  admin_username = var.admin.username
  admin_password = var.admin.password
  disable_password_authentication = false

    identity {
        type = "SystemAssigned"
    }
  
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

  source_image_reference {
      publisher = var.image.publisher
      offer     = var.image.offer
      sku       = var.image.sku
      version   = var.image.version 
  }
}