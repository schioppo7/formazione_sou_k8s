# Kubernetes basics

This exercise creates a local Kind cluster and runs a Pod that reads data from a Kubernetes Secret.

Files:

- `kind-config.yaml`: Kind cluster configuration.
- `credentials-secret.example.yaml`: Secret template with placeholder values.
- `credentials-pod.yaml`: Pod that reads the Secret.

Copy the template to `credentials-secret.yaml`, replace the placeholders and apply it locally. The real file is ignored by Git.
