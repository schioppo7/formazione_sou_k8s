#!/bin/bash

NAMESPACE="formazione-sou"
DEPLOYMENT_NAME="flask-app-release-deployment"

echo "Controllo deployment: $DEPLOYMENT_NAME"

sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml /usr/local/bin/k3s kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o yaml > /tmp/deploy.yaml 2>/dev/null

if [ ! -s /tmp/deploy.yaml ]; then
        echo "Errore: il deployment non esiste nel cluster"
        exit 1
fi

ERRORS=0

if ! grep -q "livenessProbe" /tmp/deploy.yaml; then
        echo " Attenzione: livenessProbe Mancante"
        ERRORS=$((ERRORS + 1))
fi

if ! grep -q "readinessProbe" /tmp/deploy.yaml; then
        echo " Attenzione: readinessProbe Mancante"
        ERRORS=$((ERRORS + 1))
fi

if ! grep  -q "limits" /tmp/deploy.yaml; then
        echo " Attenzione: manca il blocco limits"
        ERRORS=$((ERRORS + 1))
fi


if ! grep -q "requests" /tmp/deploy.yaml; then
        echo " Attenzione: manca il blocco requests"
        ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
        echo "ESITO DEL CHECK: il deployment non è a norma"
        rm -f /tmp/deploy.yaml
        exit 1
else
        echo "ESITO DEL CHECK: il deployment è a norma!"
        rm -f /tmp/deploy.yaml
        exit 0
fi
