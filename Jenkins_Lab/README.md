# Jenkins Lab - Vagrant & Ansible Infrastructure

This folder contains the configuration to automatically provision and configure a local Jenkins environment containing a **Jenkins Master** and a **Jenkins Agent** running as isolated Docker containers within a Rocky Linux 9 virtual machine.

---

## Architecture Overview

* **Host Machine Virtualization**: Managed via Vagrant using VirtualBox as the provider.
* **OS Distribution**: Rocky Linux 9 (`generic/rocky9`).
* **Provisioning**: Ansible manages automated software installations (Docker Engine) and infrastructure setup.
* **Network Isolation**: Jenkins Master and Agent communicate inside an isolated, static Docker network (`172.20.0.0/16`).

---

## Infrastructure Specs

### Virtual Machine (Vagrant/VirtualBox)
* **Hostname**: `jenkins-k8s-lab`
* **Private Network IP**: `192.168.56.10`
* **Resources Allocated**: 2 vCPUs, 2048 MB RAM

### Docker Container Networking
| Container Name | Role | Image | Static IP (Internal Network) | Exposed Ports |
| :--- | :--- | :--- | :--- | :--- |
| **`jenkins-master`** | Orchestrator Server | `jenkins/jenkins:lts` | `172.20.0.10` | `8080` , `50000` |
| **`jenkins-agent`** | Worker Node | `jenkins/inbound-agent` | `172.20.0.20` | Internal Only |

---

## Quick Start Guide

### Step 1: Spin up the Laboratory
Navigate to the root directory containing your `Vagrantfile` and execute the following command to download the Rocky Linux base box, provision the virtual machine, and trigger Ansible to deploy Docker, networks, and the Jenkins master/agent containers:
```bash
vagrant up

Step 2: Access the Jenkins UI
Once the setup process finishes, open your host computer's web browser and navigate to the application console:

URL: http://192.168.56.10:8080

Step 3: Retrieve Initial Admin Password
To unlock the Jenkins dashboard for the first time, SSH into your newly created virtual machine and read the system setup token directly from the running master container:

Bash
# SSH into the lab virtual machine
vagrant ssh

# Extract the password from the persisted Docker volume
sudo docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
