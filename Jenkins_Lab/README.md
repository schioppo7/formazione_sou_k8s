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
