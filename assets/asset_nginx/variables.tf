variable "instance_name" {
  type        = string
  description = "My instance name"

}

variable "machine_type" {
  type        = string
  default     = "n1-standard-1"
  description = "My instance type"

}
variable "region" {
  type        = string
  description = "Region"

}

variable "boot_disk" {

}

variable "zone" {
  type        = string
  description = "zone"

}

variable "network" {
  
}
variable "nginx_conf_source" {
  
}

variable "nginx_conf_destination" {
  
}
variable "custom_nginx_conf_source" {
  
}
variable "custom_nginx_conf_destination" {
  
}
variable "docker_install_source" {
  
}
variable "docker_install_destination" {
  
}
variable "privatekeypath" {
  
}
variable "publickeypath" {
  
}

variable "username" {
  
}
variable "connection_type"{
  
}