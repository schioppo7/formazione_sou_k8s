# Deployment compliance check

This exercise checks the `flask-app-release-deployment` Deployment in the `devops-training` namespace.

The script looks for liveness and readiness probes, resource limits, and resource requests.

`deployment_reader_rbac.yaml` contains the read-only RBAC resources used by the exercise.

```bash
cd exercises/kubernetes/deployment-compliance
chmod +x check_deployment_best_practices.sh
./check_deployment_best_practices.sh
```
