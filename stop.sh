#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="agentbox"

# Check Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check container exists and is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Container '${CONTAINER_NAME}' is not running."
    exit 0
fi

echo "Stopping agentbox..."
docker stop "$CONTAINER_NAME"
echo "agentbox stopped."
