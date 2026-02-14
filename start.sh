#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="agentbox"
MEMORY_LIMIT="8g"

# Check Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check container exists
if ! docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Error: Container '${CONTAINER_NAME}' does not exist."
    echo "Run ./init.sh first to create it."
    exit 1
fi

# Enforce memory limit on every start
docker update --memory "$MEMORY_LIMIT" "$CONTAINER_NAME" >/dev/null

# Start and attach
echo "Starting agentbox..."
docker start "$CONTAINER_NAME" >/dev/null
docker attach "$CONTAINER_NAME"
