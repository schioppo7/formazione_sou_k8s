# Flask app deployment

This exercise deploys a Flask application to Kubernetes with Helm.

The chart creates a Deployment and a ClusterIP Service on port `8000`.

```bash
cd exercises/helm/flask-app-deployment
helm upgrade --install flask-app-release charts/flask-app --namespace devops-training --create-namespace
```
