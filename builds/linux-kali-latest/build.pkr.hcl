 locals {
// 	ansible_extra_arguments = var.debug_ansible ? [
// 			"--extra-vars", "ansible_become_password=${var.os_password}",
// 			"--extra-vars", "role=${var.role}",
//       "--extra-vars", "role_config='${var.role_config}'",
// 			"-vvv",
//       "--scp-extra-args", "'-O'"

//     ]
//   sources = var.role == "base" ? [ "vsphere-iso.this" ]
  sources = [ "vsphere-iso.kali-vm" ]
}

packer {
  required_plugins {
    vsphere = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vsphere"
    }
    
    // ansible = {
    //   version = "~> 1"
    //   source = "github.com/hashicorp/ansible"
    // }
  }
}

build {
  sources = local.sources

//   provisioner "shell" {
//     inline = ["sudo apt-get install ansible -y"]
//   }

//   provisioner "ansible" {
//     playbook_file = "${path.cwd}/ansible/playbook.yaml"
//     user          = var.os_username

//     extra_arguments = local.ansible_extra_arguments

//     ansible_env_vars = [
//       "ANSIBLE_REMOTE_TMP=/tmp",
//     ]
//   }
}