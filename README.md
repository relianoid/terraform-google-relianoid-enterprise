# terraform-google-relianoid-enterprise
# RELIANOID Enterprise Edition – GCP Terraform Module

This guide explains how to deploy the **RELIANOID Enterprise Edition** virtual machine on **Google Cloud Platform (GCP)** using the official Terraform module from the **Terraform Registry**.

---

## What this module provisions automatically

- VPC Network  
- Subnet  
- Firewall Rule (allowing SSH `22`, Web GUI `444`)  
- Static External IP  
- Network Interface  
- Compute Instance using the **RELIANOID Enterprise Edition image** from **Google Cloud Marketplace**

---

## Prerequisites

### 1. Install Terraform
Download and install Terraform for your operating system:

```bash
terraform -version
```

### 2. Install Google Cloud SDK
Download and install the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install).

Authenticate to your Google Cloud account:

```bash
gcloud auth login
gcloud config set project <YOUR_PROJECT_ID>
```

### 3. Generate SSH Key Pair
You’ll need an SSH key to access the VM. If you don’t already have one:

```bash
ssh-keygen -t rsa -b 4096 -f id_rsa
```

This creates **id_rsa** (private key) and **id_rsa.pub** (public key).  
Keep both in the same directory where Terraform files are stored.

---

## Step 1: Find the Terraform Module

Go to [Terraform Registry](https://registry.terraform.io)  
Search for: **relianoid/relianoid-enterprise/google**

---

## Step 2: Create a Project Folder

```bash
mkdir relianoid-gcp
cd relianoid-gcp
```

---

## Step 3: Create Configuration Files

Create these files:

- `main.tf`
- `variables.tf`
- `terraform.tfvars`
- `outputs.tf`

### **main.tf**
```hcl
module "relianoid-enterprise" {
  source              = "relianoid/relianoid-enterprise/google"
  version             = "1.0.0"

  project_id          = var.project_id
  region              = var.region
  zone                = var.zone
  public_ssh_key_path = "${path.module}/id_rsa.pub"
}
```

---

### **variables.tf**
```hcl
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region for resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone for VM deployment"
  type        = string
  default     = "us-central1-a"
}
```

---

### **terraform.tfvars**
```hcl
project_id = "your-gcp-project-id"
region     = "us-central1"
zone       = "us-central1-a"
```

---

### **outputs.tf**
```hcl
output "instance_id" {
  description = "The ID of the GCP VM instance"
  value       = module.relianoid-enterprise.instance_id
}

output "instance_public_ip" {
  description = "The public IP address of the RELIANOID VM"
  value       = module.relianoid-enterprise.instance_public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the RELIANOID VM"
  value       = module.relianoid-enterprise.instance_private_ip
}
```

---

## Step 4: Initialize & Deploy

Run the following commands:

```bash
terraform init
terraform plan
terraform apply
```

Confirm with **yes** when prompted.

---

## Step 5: Access the RELIANOID VM

After deployment, Terraform outputs the **public IP address**.

Connect via SSH:

```bash
ssh -i id_rsa admin@<instance_public_ip>
```

> The default username is admin.

Access the Web GUI in your browser:

```
https://<instance_public_ip>:444
```

---

## Outputs

| Output Name | Description |
|--------------|-------------|
| **instance_id** | The ID of the GCP VM instance |
| **instance_public_ip** | The public IP address of the VM |
| **instance_private_ip** | The private IP address of the VM |

---

##  Destroy Resources

To delete everything created by Terraform:

```bash
terraform destroy
```

---

## ⚠️ Important Notes

- Make sure you have accepted the **Google Cloud Marketplace terms** for the RELIANOID image before deployment.  
- Keep your **private key (`id_rsa`)** secure — never share it publicly.  
- The module provisions networking, firewall, and compute resources automatically.

---

© 2025 RELIANOID. All rights reserved.

