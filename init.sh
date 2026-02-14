#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="agentbox"
CONTAINER_NAME="agentbox"
MEMORY_LIMIT="8g"
WORKSPACE_DIR="$(cd "$(dirname "$0")" && pwd)/workspace"

# Check Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Create workspace directory if it doesn't exist
mkdir -p "$WORKSPACE_DIR"

# Remove existing container if present
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Removing existing '${CONTAINER_NAME}' container..."
    docker rm -f "$CONTAINER_NAME" >/dev/null
fi

# Build the image
echo "Building '${IMAGE_NAME}' image..."
docker build -t "$IMAGE_NAME" "$(dirname "$0")"

# Create the container
echo "Creating '${CONTAINER_NAME}' container..."
docker create \
    --name "$CONTAINER_NAME" \
    --memory "$MEMORY_LIMIT" \
    --interactive --tty \
    --volume "$WORKSPACE_DIR:/workspace" \
    "$IMAGE_NAME" \
    fish

echo ""
echo "agentbox is ready!"
echo ""
echo "Next steps:"
echo "  1. Run ./start.sh to enter the container"
echo "  2. Run 'claude' inside the container to start Claude Code"
echo "  3. Files in ./workspace/ are shared with the container at /workspace"
