---
title: Ollama
emoji: 🏆
colorFrom: gray
colorTo: gray
sdk: docker
pinned: false
license: mit
---

Check out the configuration reference at https://github.com/Neiman-Tech/ollama.git

---

## Build an Image Tag

\```sh
docker build -t tech .
\```

## Run the Container

\```bash
docker run -p 11434:11434 --name neiman-tech tech
\```

### Command Breakdown

| Command/Flag | Description |
|---|---|
| `docker run` | Start a container |
| `-d` | Run in background (detached mode) |
| `-p 11434:11434` | Expose port 11434 (for Ollama) |
| `--name neiman-tech` | Give it a name |
| `tech` | Use the image we just built |

---

## Container Management

### Check Running Containers

\```sh
docker ps
\```

### View Container Logs

\```sh
docker logs neiman-tech
\```

### Stop the Container

\```sh
docker stop neiman-tech
\```

### Remove the Container

\```sh
docker rm neiman-tech
\```