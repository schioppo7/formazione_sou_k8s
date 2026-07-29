# DevOps Training Labs

Hands-on exercises created during a DevOps training course.

The roadmap starts with configuration management, continues with CI pipelines
and container images, and finishes with Kubernetes application delivery.

## Technologies

- Ansible, Jinja2, Ansible Vault and Vagrant
- Jenkins, Git and Docker
- Python and Flask
- Kubernetes, Kind, Helm and Bash

## Roadmap

### 1. Configuration management

- [Ansible lab](exercises/ansible/ansible-lab/) - create a Rocky Linux VM and manage it with inventories and playbooks.
- Continue with the [main playbooks](exercises/ansible/ansible-lab/playbooks/) and the exercises about [lists](exercises/ansible/ansible-lab/bonus-exercises/lists/), [Jinja templates](exercises/ansible/ansible-lab/bonus-exercises/jinja-templates/) and [Ansible Vault](exercises/ansible/ansible-lab/bonus-exercises/vault/).

### 2. Jenkins and containers

- [Jenkins lab](exercises/jenkins/jenkins-lab/) - run a Jenkins controller and agent with Docker.
- Practice with the [date pipeline](exercises/jenkins/date-pipeline/) and the [declarative Flask pipeline](exercises/jenkins/declarative-pipeline/).

### 3. Kubernetes application delivery

- [Kubernetes basics](exercises/kubernetes/basics/) - create a Kind cluster and use a Secret.
- [Flask deployment with Helm](exercises/helm/flask-app-deployment/) - deploy the application with a chart.
- [Deployment compliance check](exercises/kubernetes/deployment-compliance/) - check probes, resource requests and limits.

## How to use the repository

Open a lab folder and read its README before running the files. Start with the
Ansible lab if you want to follow the full roadmap, or choose a section to
practice one technology.
