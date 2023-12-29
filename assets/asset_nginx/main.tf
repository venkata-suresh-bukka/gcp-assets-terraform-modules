provider "google" {
  credentials = "key.json"
  project     = "sunlit-vortex-356909"
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  

  boot_disk {
    initialize_params {
      image = var.boot_disk
    }
  }
  network_interface {
    network    = var.network
    access_config {
    }
  
  }
  metadata = {
    ssh-keys = "${var.username}:${file(var.publickeypath)}"
  }

  provisioner "file" {
    source      = var.nginx_conf_source
    destination = var.nginx_conf_destination
  }
  provisioner "file" {
    source      = var.custom_nginx_conf_source
    destination = var.custom_nginx_conf_destination
  }
  provisioner "file" {
    source      = var.docker_install_source
    destination = var.docker_install_destination
  }
   connection {
      host = self.network_interface.0.access_config.0.nat_ip
      type = var.connection_type
      user = var.username
      private_key = file(var.privatekeypath)
    } 
  provisioner "remote-exec" { 
    connection {
      host = self.network_interface.0.access_config.0.nat_ip
      type = var.connection_type
      user = var.username
      private_key = file(var.privatekeypath)
    }
    inline = [
      "sudo  apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo cp /home/venkat_nginx/docker-install.sh /docker-install.sh",
      "sudo chmod +x docker-install.sh",
      "sudo ./docker-install.sh",
      "sudo cp /home/venkat_nginx/nginx.conf /etc/nginx/nginx.conf",
      "sudo cp /home/venkat_nginx/custom-nginx.conf /etc/nginx/conf.d/custom-nginx.conf",
      "sudo rm -r /etc/nginx/sites-enabled/default",
      "sudo usermod -aG docker $USER",
      "sudo docker pull venkatrobin/flask-demo:v1",
      "sudo docker run -d -p 5000:5000 --name flask venkatrobin/flask-demo:v1",
      "sudo nginx -t",
      "sudo systemctl reload nginx"
    ]
  }
}



resource "google_compute_firewall" "firewall" {
  name    = "nginx-test"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80","8080","443","5000"]
  }
  source_ranges = ["0.0.0.0/0"]
}

