# Jenkins Lab

This lab creates a Rocky Linux 9 virtual machine with Vagrant.
Ansible installs Docker and starts a Jenkins Master and Agent in separate containers.

Set the `JENKINS_AGENT_SECRET` environment variable before starting the lab.
Keep its value local and do not add it to this repository.
