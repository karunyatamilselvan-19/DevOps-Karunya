#!/bin/bash
set -euo pipefail
IMAGE="${1:-youruser/devops-app}"
TAG="${2:-latest}"
cd "$(dirname "$0")/.."
(cd app && python3 -m unittest)
docker build -t "$IMAGE:$TAG" -f docker/Dockerfile .
echo "Built $IMAGE:$TAG  (push with: docker push $IMAGE:$TAG)"
