
source "vsphere-iso" "kali-vm" {
  
  // Connection details
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  insecure_connection  = var.vcenter_insecure_connection
  
  // Where to build
  datacenter           = var.datacenter
  cluster              = var.cluster
  datastore            = var.datastore
  folder               = var.folder

  // VM configuration
  convert_to_template  = true
  vm_name              = "kali-template"
  guest_os_type        = var.guest_os_type

  CPUs = 4
  RAM  = 4096

  disk_controller_type = ["pvscsi"]
  cdrom_type           = "sata"

  storage {
    disk_size             = 35000
    disk_thin_provisioned = true
  }

  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }

  iso_url              = var.iso_url
  iso_checksum         = var.iso_checksum
  
  // preseed packer hosting
  http_directory = "./builds/linux-kali-latest/http/"
  http_ip = "10.1.0.250"

  boot_wait            = "3s"
  boot_command = [
    "<esc><wait>",
    "install <wait>",
    "locale=en_US ",
    "keymap=us ",
    "auto=true ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "priority=critical ",
    "<enter>"
  ]

  // post build connectivity
  ssh_username         = var.os_username
  ssh_password         = var.os_password

  tools_upgrade_policy = true
  shutdown_timeout = "1h"
}
