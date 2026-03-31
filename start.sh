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

# Start container and give it a moment to initialize.
echo "Starting agentbox..."
docker start "$CONTAINER_NAME" >/dev/null
sleep 1

# Check if tmux server is running.
if docker exec "$CONTAINER_NAME" tmux info &>/dev/null; then
    # If server is running, create a new session for the new user.
    echo "Attaching to agentbox by creating a new tmux session..."
    docker exec -it "$CONTAINER_NAME" tmux new-session
else
    # If no server, this is the first user. Start tmux server and attach.
    echo "Attaching to agentbox by starting a new tmux server..."
    docker exec -it "$CONTAINER_NAME" tmux
fi
