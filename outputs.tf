output "instance_id" {
  value = google_compute_instance.relianoid_vm.instance_id
}

output "instance_public_ip" {
  description = "The public IP of the GCP VM"
  value       = google_compute_address.public_ip.address
}

output "instance_private_ip" {
  description = "The private IP of the GCP VM"
  value       = google_compute_instance.relianoid_vm.network_interface[0].network_ip
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i id_rsa ${var.admin_username}@${google_compute_address.public_ip.address}"
}
