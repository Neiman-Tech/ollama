---
title: Ollama
emoji: 🏆
colorFrom: gray
colorTo: gray
sdk: docker
pinned: false
license: mit
---

# Ollama Docker Setup

This guide will help you build and run Ollama in a Docker container.

**Configuration Reference:** https://github.com/Neiman-Tech/ollama.git

---

## Building the Docker Image

First, build the Docker image and tag it as `tech`:
```sh
docker build -t tech .
```

This command creates a Docker image from the Dockerfile in your current directory.

---

## Running the Container

Start the container with the following command:
```bash
docker run -d -p 11434:11434 --name neiman-tech tech
```

### What each flag does:

| Flag | Purpose |
|------|---------|
| `docker run` | Creates and starts a new container |
| `-d` | Runs container in detached mode (background) |
| `-p 11434:11434` | Maps port 11434 from container to host (Ollama's default port) |
| `--name neiman-tech` | Assigns a friendly name to the container |
| `tech` | Specifies which image to use |

---

## Managing Your Container

### Check if the container is running
```sh
docker ps
```

Shows all currently running containers.

### View container logs
```sh
docker logs neiman-tech
```

Displays what's happening inside your container - useful for debugging.

### Stop the container
```sh
docker stop neiman-tech
```
### Start it again
```sh
docker run neiman-tech
```
Gracefully stops the running container.

### Remove the container
```sh
docker rm neiman-tech
```

Deletes the container (must be stopped first).RetryClaude does not have the ability to run the code it generates yet.