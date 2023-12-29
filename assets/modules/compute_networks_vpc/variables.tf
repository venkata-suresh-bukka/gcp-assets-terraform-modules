##-----------------------------------------------SUBNET1 FOR CUSTOM VPC----------------------------------#
variable "custom_subnet_cidr" {
  type        = string
  description = "custom subnet cidr range"
}
variable "custom_subnet_region" {
  type        = string
  description = "custom subnet region"
}

##-----------------------------------------------SUBNET2 FOR CUSTOM VPC----------------------------------#

variable "custom_subnet_cidr2" {
  type        = string
  description = "custom subnet cidr range"
}
variable "custom_subnet_region2" {
  type        = string
  description = "custom subnet region"
}

##-----------------------------------------------INSTANCE1 IN CUSTOM VPC SUBNET1--------------------------------#

variable "custom_vpc_instance_machine_type" {
  type        = string
  description = "custom vpc instance machine type"
}
variable "custom_vpc_instance_zone" {
  type        = string
  description = "custom vpc instance zone"
}
variable "custom_vpc_instance_boot_disk" {
  type        = string
  description = "custom vpc instance boot disk image"
}
variable "custom_vpc_instance_disk_label" {
  type        = string
  description = "custom vpc instance boot disk label"
}

##-----------------------------------------------INSTANCE2 IN CUSTOM VPC SUBNET2 note:used remaining config from above--------------------------------#

variable "custom_vpc_instance_zone2" {
  type        = string
  description = "custom vpc instance zone"
}

##-------------------------------------------------FIREWALL RULE FOR CUSTOM VPC--------------------------------#
variable "custom-vpc-instance-firewall-ports" {
  type        = list(string)
  description = "custom vpc instance firewall ports"
}
variable "custom-vpc-instance-firewall-tcp-protocol" {
  type        = string
  description = "custom vpc instance firewall tcp protocol"
}
variable "custom-vpc-instance-firewall-icmp-protocol" {
  type        = string
  description = "custom vpc instance firewall icmp protocol"
}
