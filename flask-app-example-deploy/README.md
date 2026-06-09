# Flask App Example Deploy (Helm & Kubernetes)

This repository contains the Helm Chart for the automated deployment on Kubernetes of a web application written in Python using the **Flask** framework. 

The application is configured to listen internally on port `8000` and is optimized for local development/lab environments (such as clusters managed within Vagrant VMs).

---

## Deployment Architecture

The Helm Chart manages and coordinates the following native Kubernetes components:
* **Deployment**: Configures a replicated set of Pods based on the official Docker image pulled from Docker Hub.
* **Service (ClusterIP)**: Exposes the application internally within the cluster, load-balancing network traffic to port `8000` of the containers.

---

## Prerequisites

Before starting the deployment, ensure you have the following installed and configured in your environment:
* **Kubernetes** v1.20+ (e.g., k3s, Minikube, or a kubeadm cluster)
* **Helm v3**
* Internet connection to pull the Docker image from Docker Hub
