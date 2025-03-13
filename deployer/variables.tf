variable "image" {
    description = "The image to use for the virtual machine."
    type        = object({
        publisher = string
        offer     = string
        sku       = string
        version   = optional(string, "latest")
    })
    default = {
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-focal"
      sku = "20_04-lts-gen2"
      version = "latest"
    }
}

variable "vnet" {
        type = object({
        name = string
        rg  = string
        subnet = string
    })
    description = "required virtual network details"
}

variable "name_prefix" {
  description = "Prefix for naming the deployer VM and associated resources (i.e., nic, disk, etc)."
  type        = string
  
}

variable "resource_group_name" {
  description = "Name of the target resource group."
  type        = string
}

variable "azhop_rg" {
  description = "Azhop RG"
  type        = string  
}

variable "admin" {
        type = object({
        username = optional(string, "hpcadmin")
        password = string
    })
    description = "details of admin account - username of hpcadmin is default"
}

variable "vm_size" {
  description = "Size of the virtual machine."
  type        = string
  default     = "Standard_B2ms"
  
}

variable "ubuntu_pro_token" {
  description = "Ubuntu Pro token for the VM."
  type        = string
  default     = ""
  
}

variable "packages" {
  description = "List of packages to install on the VM."
  type        = list(string)
  default     = ["wget" , "git"]
}

