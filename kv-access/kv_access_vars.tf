variable "kv_rg_name" {
  description = "Name of the resource group that the key vault is in"
  type        = string
}

variable "kv_name" {
  description = "Name of the target key vault"
  type        = string
}

variable "tenant_id" {
  description = "ID of target tenant"
  type        = string
}

variable "mi_obj_id" {
  description = "Object ID of identity that will be granted access to the key vault"
  type        = string
}

