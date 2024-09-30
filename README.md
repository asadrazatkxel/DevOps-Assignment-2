# DevOps-Assignment-2
Please look into the Ansible Beginner Course and Terraform Beginners Course from Kodekloud to complete the assignment

### Hi Asad,

 - Install Terraform latest on your machine and (also look into Terraform cloud for your knowledge )
 - Write a terraform script to create a vnet and VM instance on the Azure cloud 
 - Install Ansible on your machine using Linux Bash Script
 - Create an Ansible playbook that installs Docker and Docker-Compose on your local machine
 - Must read about Ansible Role and its uses.

---

# DevOps Assignment 2 - Terraform, Ansible, and Docker Setup

## Overview

This project showcases my journey through various DevOps tasks, including:

1. Installing Terraform and exploring Terraform Cloud.
2. Writing a Terraform script to create a Virtual Network (VNet) and Virtual Machine (VM) instance on Azure.
3. Installing Ansible using a Linux Bash script.
4. Creating an Ansible playbook to install Docker and Docker-Compose on a local machine.
5. Learning about Ansible Roles and their uses.

---

## Prerequisites

Before running the scripts, ensure the following are installed on your machine:

- [Terraform](https://www.terraform.io/downloads.html)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- A working Azure subscription (i'm using the KODEKLOUD playground)

---

## Steps to Complete

### 1. Install Terraform (Latest Version)

- Download and install the latest version of Terraform by following the official [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- (Optional) Explore Terraform Cloud for cloud-based Terraform state storage and team collaboration.

### 2. Write a Terraform Script for VNet and VM on Azure

#### Files:
- `linux-vm.tf`: Contains the configuration to create:
  - Azure Resource Group
  - Virtual Network
  - Subnet
  - Network Security Group
  - Public IP Address
  - Network Interface
  - Linux Virtual Machine

#### Steps:
1. Create a new Azure Resource Group.
2. Define a Virtual Network and Subnet.
3. Attach Network Security Group with rules for SSH (port 22), HTTP (port 80), and HTTPS (port 443).
4. Create a Public IP Address and Network Interface.
5. Provision a Linux VM with SSH key-based authentication.

**Execution Command:**

```bash
terraform init
terraform plan
terraform refresh
terraform fmt
terraform apply
```

#### Common Errors:
- **Error**: `AuthorizationFailed` (403) - Lack of permissions on resource groups, virtual networks, or public IP.
  **Solution**: Ensure that the logged-in Azure account has proper permissions or update your credentials using `az login`.

### 3. Install Ansible Using a Bash Script

- I wrote a Bash script (`install_ansible.sh`) to install Ansible on Ubuntu 24 (Jellyfish):

```bash
#!/bin/bash
sudo apt update
sudo apt install -y ansible
```

Run the script:
```bash
chmod +x install_ansible.sh
./install_ansible.sh
```

### 4. Create an Ansible Playbook to Install Docker and Docker-Compose

#### Playbook: `docker_install.yml`

- This playbook installs Docker and Docker-Compose on a local machine.

```yaml
---
- hosts: localhost
  become: true
  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present
        update_cache: yes

    - name: Install Docker-Compose
      apt:
        name: docker-compose
        state: present
```

Run the playbook:
```bash
ansible-playbook docker_install.yml
```

### 5. Learn About Ansible Roles

Ansible roles help modularize playbooks, making it easier to reuse and organize code. I studied how to create a role to install Docker, breaking tasks into smaller reusable units.

---

## Challenges Faced

1. **Azure Permissions Issues**:
   - Faced several 403 `AuthorizationFailed` errors while running Terraform scripts. This was due to inadequate permissions in Azure. I solved this by updating the Azure CLI session and ensuring the correct subscription was set.
  
2. **Network Security Group Errors**:
   - Initially received an error when associating the NSG with the network interface. I resolved it by using the correct argument `azurerm_subnet_network_security_group_association` instead of directly linking it.

3. **Terraform Azure Resource Group Issue**:
   - Encountered errors where the resource group ID was incorrectly referenced across resources. Solved by reviewing the naming and referencing within the script.

---

## Summary of Learnings

Today, I deepened my understanding of key DevOps concepts:

- **Terraform**: Learned how to automate the provisioning of Azure resources, overcoming access and permission-related challenges. I also explored how Terraform Cloud can be utilized for remote state management.  
- **Ansible**: Successfully installed and configured Ansible, creating a playbook to automate Docker installation. Understanding Ansible roles helped me realize the importance of modularizing infrastructure as code.

These skills will prove vital for future DevOps projects and automation tasks.

---

Feel free to ask any questions or open issues regarding the configuration!


