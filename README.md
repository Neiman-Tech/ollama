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

docker run = start a container
-d = run in background (detached mode)
-p 11434:11434 = expose port 11434 (for Ollama)
--name neiman-tech = give it a name
  tech = use the image we just built


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