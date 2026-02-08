# agentbox

Isolated, containerized development environment with Claude Code, GitHub CLI, and fish shell.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running

## Quick Start

```bash
# 1. Initialize the environment (builds image, creates container)
./init.sh

# 2. Start and attach to the container
./start.sh

# 3. Stop the container when done
./stop.sh
```

## What's Inside

The container comes with:

- **fish shell** (default shell)
- **Claude Code** CLI
- **GitHub CLI** (`gh`)
- **vim**, **git**, **curl**
- Node.js 22

## Authenticating Claude Code

On first run inside the container:

```bash
claude
```

Follow the prompts to authenticate with your Anthropic API key or OAuth.

## Workspace

The `workspace/` directory is mounted into the container at `/workspace`. Files you create or edit inside the container appear on your host machine and vice versa. This directory is gitignored so your project files stay local.

## Customizing

Edit the `Dockerfile` to add tools or change configuration, then re-run:

```bash
./init.sh
```

This rebuilds the image and recreates the container. Your `workspace/` files are preserved since they live on the host.
