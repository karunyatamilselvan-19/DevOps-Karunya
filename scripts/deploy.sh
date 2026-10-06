#!/bin/bash
# Usage: scripts/deploy.sh dev|prod
set -euo pipefail
ENV="${1:-dev}"
cd "$(dirname "$0")/.."
kubectl create namespace "$ENV" --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -k "kubernetes/overlays/$ENV"
kubectl -n "$ENV" rollout status deployment/devops-app
