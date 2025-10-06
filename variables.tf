variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "relianoid-vpc"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "relianoid-subnet"
}

variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
  default     = "relianoid-public-ip"
}

variable "vm_name" {
  description = "VM instance name"
  type        = string
  default     = "relianoid-community-vm"
}

variable "machine_type" {
  description = "GCP VM machine type"
  type        = string
  default     = "e2-medium"
}

variable "admin_username" {
  description = "Admin username for SSH access"
  type        = string
  default     = "admin"
}

variable "public_ssh_key_path" {
  description = "Path to SSH public key"
  type        = string
}
