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


# **BUILD AN IMAGE TAG**
```sh
docker build -t tech .
```
## RUN
```bash
bashdocker run -p 11434:11434 --name neiman-tech tech
```
**Let me explain what each part does:**

| Command/Flag | Description |
|---|---|
| `docker run` | Start a container |
| `-d` | Run in background (detached mode) |
| `-p 11434:11434` | Expose port 11434 (for Ollama) |
| `--name neiman-tech` | Give it a name |
| `tech` | Use the image we just built |


### CHECK STATUS

```sh
docker ps
```
##### CHECK WHAT's HAPPENING INSIDE 
```sh
docker logs neiman-tech
```

###### TO STOP THE CONTAINER 

```sh
docker stop neiman-tech 

```

###### TO REMOVE THE CONTAINER 

```sh
docker remove neiman-tech 

```