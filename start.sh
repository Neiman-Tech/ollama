#!/bin/bash

# Start Ollama in the background
ollama serve &

# Wait for Ollama to be ready
echo "Waiting for Ollama to start..."
sleep 5

# Pull the model
echo "Pulling llama3.2 model..."
ollama pull llama3.2

# Start cloudflared tunnel and save the URL
echo "Starting cloudflared tunnel..."
cloudflared tunnel --url http://127.0.0.1:11434 > tunnel.log 2>&1 &

# Wait for tunnel to start and extract URL
sleep 5
TUNNEL_URL=$(grep -oP 'https://.*?\.trycloudflare\.com' tunnel.log | head -1)

echo "=========================================="
echo "Ollama is running!"
echo "Tunnel URL: $TUNNEL_URL"
echo "API Endpoint: $TUNNEL_URL/api/generate"
echo "=========================================="

# Save URL to a file for easy access
echo $TUNNEL_URL > tunnel_url.txt

# Keep the container running
tail -f tunnel.log