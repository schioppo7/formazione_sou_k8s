# - Declarative Jenkins Pipeline (Groovy) for Docker Image Build

This document describes the requirements, structure, and logic of the `flask-app-example-build` declarative pipeline. It automates building and pushing the Docker image to Docker Hub with dynamic tagging based on the Git lifecycle.

---

## 1. Environment Prerequisites

Before running the pipeline, ensure you have completed the following preliminary steps:

* **GitHub Repository:** Create a public or private repository named `formazione_sou_k8s`.
* **Docker Hub Account:** Create a personal account (e.g., `schioppo7`) and generate an *Access Token* from your security settings.
* **Jenkins Credentials:** Configure a *Username with password* credential in the Jenkins global store with the ID **`dockerhub-credentials`**.

---

## 2. Application Dockerfile (Flask)

The `Dockerfile` located in the root of the project configures the Python Flask application to expose the "Hello, World!" string on port `8000`:

```dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=8000

CMD ["flask", "run"]
