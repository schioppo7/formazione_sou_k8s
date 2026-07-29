#!/bin/bash

NAMESPACE="devops-training"
DEPLOYMENT_NAME="flask-app-release-deployment"

echo "Checking deployment: $DEPLOYMENT_NAME"

sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml /usr/local/bin/k3s kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o yaml > /tmp/deploy.yaml 2>/dev/null

if [ ! -s /tmp/deploy.yaml ]; then
        echo "Error: the deployment does not exist in the cluster"
        exit 1
fi

ERRORS=0

if ! grep -q "livenessProbe" /tmp/deploy.yaml; then
        echo " Warning: livenessProbe is missing"
        ERRORS=$((ERRORS + 1))
fi

if ! grep -q "readinessProbe" /tmp/deploy.yaml; then
        echo " Warning: readinessProbe is missing"
        ERRORS=$((ERRORS + 1))
fi

if ! grep  -q "limits" /tmp/deploy.yaml; then
        echo " Warning: the limits block is missing"
        ERRORS=$((ERRORS + 1))
fi


if ! grep -q "requests" /tmp/deploy.yaml; then
        echo " Warning: the requests block is missing"
        ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
        echo "CHECK RESULT: the deployment does not meet the requirements"
        rm -f /tmp/deploy.yaml
        exit 1
else
        echo "CHECK RESULT: the deployment meets the requirements!"
        rm -f /tmp/deploy.yaml
        exit 0
fi
