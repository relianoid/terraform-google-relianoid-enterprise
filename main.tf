provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Firewall - Allow SSH & Web GUI
resource "google_compute_firewall" "relianoid_firewall" {
  name    = "relianoid-allow-ssh-web"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "444"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Static External IP
resource "google_compute_address" "public_ip" {
  name   = var.public_ip_name
  region = var.region
}

# RELIANOID VM Instance
resource "google_compute_instance" "relianoid_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["relianoid"]

  boot_disk {
    initialize_params {
      image = "projects/relianoid-public/global/images/relianoid-enterprise-edition"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id

    access_config {
      nat_ip = google_compute_address.public_ip.address
    }
  }

  metadata = {
    ssh-keys = "${var.admin_username}:${file(var.public_ssh_key_path)}"
  }
}
