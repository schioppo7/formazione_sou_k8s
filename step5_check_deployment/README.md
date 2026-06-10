# Deployment Compliance and Best Practices Check

This script automates the verification of minimum security and reliability requirements (Best Practices) for our deployments within the Kubernetes (K3s) cluster.

## Automation Objective
The goal is to ensure that the deployment `flask-app-release-deployment` in the `formazione-sou` namespace complies with the following corporate standards:
1. **Liveness Probe** configured (container health check).
2. **Readiness Probe** configured (traffic readiness check).
3. **Resource Limits** set (maximum CPU/Memory cap).
4. **Resource Requests** set (minimum guaranteed resources at startup).

If one or more of these attributes are missing, the automation halts execution and returns an error.

---

## Strategy Used: kubectl Wrapping
For this automation, i chose the **kubectl Wrapping** strategy via a Bash script. 

The script operates as follows:
* It queries the cluster directly using the `kubectl` CLI in a secure manner (bypassing local proxy or networking conflicts such as Jenkins).
* It exports the live deployment configuration in YAML format to a temporary file (`/tmp/deploy.yaml`).
* It performs a targeted textual analysis using the `grep` command to verify the presence of the required configuration blocks.

---

## How to Run the Check

1. Navigate to the step folder:
   ```bash
   cd /home/vagrant/formazione_sou_k8s/step5_check_deployment

2. Grant execution permissions to the script:
   ```bash
   chmod +x check_best_practices.sh

3.  Run the checking script:
   ```bash
   ./check_best_practices.sh
