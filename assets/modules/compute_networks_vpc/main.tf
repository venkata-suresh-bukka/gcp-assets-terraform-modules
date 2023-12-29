#-------------------------------------------AUTO VPC---------------------#
resource "google_compute_network" "google-auto-vpc" {
  name                    = "auto-vpc"
  auto_create_subnetworks = true
}

#-------------------------------------------CUSTOM VPC---------------------#

resource "google_compute_network" "google-custom-vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}

#-------------------------------------------CUSTOM VPC SUBNET IN "asia-south2" region ---------------------#

resource "google_compute_subnetwork" "google-custom-subnet" {
  name          = "custom-subnet"
  network       = google_compute_network.google-custom-vpc.id
  ip_cidr_range = var.custom_subnet_cidr
  region        = var.custom_subnet_region
}

#-------------------------------------------CUSTOM VPC SUBNET2 IN "us-west1" region---------------------#

resource "google_compute_subnetwork" "google-custom-subnet2" {
  name          = "custom-subnet2"
  network       = google_compute_network.google-custom-vpc.id
  ip_cidr_range = var.custom_subnet_cidr2
  region        = var.custom_subnet_region2
}

#-------------------------------------------CUSTOM VPC SUBNET1 instance1 IN "asia-south2-a" zone---------------------#

resource "google_compute_instance" "custom-vpc-instance" {
  name          = "custom-vpc-instance"
  machine_type  = var.custom_vpc_instance_machine_type
  zone          = var.custom_vpc_instance_zone
   boot_disk {
    initialize_params {
      image      = var.custom_vpc_instance_boot_disk
      labels     = {
        my_label = var.custom_vpc_instance_disk_label
      }
    }
  }
  network_interface {
    network    = google_compute_network.google-custom-vpc.id
    subnetwork = google_compute_subnetwork.google-custom-subnet.id
    access_config {
    }
  }
}

#-------------------------------------------CUSTOM VPC SUBNET2 instance2 IN "us-west1-a" zone---------------------#

resource "google_compute_instance" "custom-vpc-instance2" {
  name         = "custom-vpc-instance2"
  machine_type = var.custom_vpc_instance_machine_type
  zone         = var.custom_vpc_instance_zone2
   boot_disk {
    initialize_params {
      image     = var.custom_vpc_instance_boot_disk
      labels    = {
        my_label = var.custom_vpc_instance_disk_label
      }
    }
  }
  network_interface {
    network    = google_compute_network.google-custom-vpc.id
    subnetwork = google_compute_subnetwork.google-custom-subnet2.id
    access_config {
    }
  }
}


#-------------------------------------------CUSTOM VPC FIREWALL---------------------#

resource "google_compute_firewall" "custom-vpc-instance-firwall" {
  name    = "vpc-instance-firewall"
  network = google_compute_network.google-custom-vpc.name
  allow {
    ports    = var.custom-vpc-instance-firewall-ports
    protocol = var.custom-vpc-instance-firewall-tcp-protocol
  }
  allow {
    protocol = var.custom-vpc-instance-firewall-icmp-protocol
  }
}