// // Ansible role
// variable "role_config" {
//   type    = string
//   default = env("ROLE_CONFIG")
// }

// vSphere connection details

variable "vcenter_server" {
  type = string
  default = env("VCENTER_SERVER")
}

variable "vcenter_username" {
  type = string
  default = env("VCENTER_USERNAME")
}

variable "vcenter_password" {
  type = string
  default = env("VCENTER_PASSWORD")
}

variable "vcenter_insecure_connection" {
  type    = string
  default = false
}

// User and connectivity
variable "os_username" {
  type    = string
  default = "kali"
}

variable "os_password" {
  type    = string
  default = "kali"
}

// Where to build
variable "datacenter" {
  type = string
}

variable "cluster" {
  type = string
}

variable "datastore" {
  type = string
}

variable "network" {
  type = string
}

variable "folder" {
  type    = string
  default = "templates"
}

// VM configuration
variable "guest_os_type" {
  type    = string
  default = "debian10_64Guest"
}

variable "iso_url" {
  type    = string
  default = env("iso_url")
}

variable "iso_checksum" {
  type    = string
  default = env("iso_checksum")
}

// Metadata
// variable "role" {
//   type        = string
//   description = "The Ansible roles to trigger as part of the build process."
// }

// variable "debug_ansible" {
// 	type = bool
// 	default = false
// }