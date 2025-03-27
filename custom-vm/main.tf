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
data "azurerm_subscription" "primary" {
}

data "azurerm_virtual_network" "vnet" {
    name                = var.vnet.name
    resource_group_name = var.vnet.rg
}

data "azurerm_subnet" "vm_subnet" {
  name                 = var.vnet.subnet 
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.name_prefix}-nic"
  location            = data.azurerm_virtual_network.vnet.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm-nic-ip"
    subnet_id                     = data.azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "custom_vm" {
  name                  = "${var.name_prefix}-vm"
  location              = data.azurerm_virtual_network.vnet.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
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

  #source_image_reference {
  #    publisher = var.image.publisher
  #    offer     = var.image.offer
  #    sku       = var.image.sku
  #    version   = var.image.version 
  #}
  source_image_id = var.image_id

    dynamic "plan" {
    for_each = try (length(var.image_plan.name) > 0, false) ? [1] : []
    content {
        name      = var.image_plan.name
        publisher = var.image_plan.publisher
        product   = var.image_plan.product
    }
  }
}

#resource "azurerm_virtual_machine_run_command" "install_run_cmd" {
#  name                = "${var.name_prefix}-install"
#  location            = azurerm_linux_virtual_machine.deployer.location
#  virtual_machine_id  = azurerm_linux_virtual_machine.deployer.id

#  source {
#    script = templatefile("${path.module}/install.tfpl", { upro_token = var.ubuntu_pro_token, packages = join(" ", [for cmd in var.packages : "\"${cmd}\""]) })
#  }
#}

#resource "local_file" "install_script" {
#    content  = templatefile("${path.module}/install.tfpl", {upro_token = var.ubuntu_pro_token, packages = join(" ", [for cmd in var.packages : "\"${cmd}\""])})
#    filename = "${path.module}/install.sh"
#}