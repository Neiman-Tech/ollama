#!/bin/bash

set -e

# Start Ollama in the background
echo "Starting Ollama server..."
OLLAMA_HOST=0.0.0.0:11434 ollama serve > ollama.log 2>&1 &
OLLAMA_PID=$!

# Wait for Ollama to be ready
echo "Waiting for Ollama to start..."
for i in {1..30}; do
    if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
        echo "Ollama is ready!"
        break
    fi
    sleep 1
done

# Pull the model
echo "Pulling llama3.2 model..."
ollama pull llama3.2

# Start the proxy server
echo "Starting text streaming proxy..."
python3 proxy.py > server.log 2>&1 &
SERVER_PID=$!
sleep 3

# Start cloudflared tunnel pointing to proxy (port 8080)
echo "Starting cloudflared tunnel..."
cloudflared tunnel --url http://127.0.0.1:8080 > tunnel.log 2>&1 &
TUNNEL_PID=$!

# Wait for tunnel URL
echo "Waiting for tunnel URL..."
for i in {1..20}; do
    TUNNEL_URL=$(grep -oP 'https://.*?\.trycloudflare\.com' tunnel.log 2>/dev/null | head -1)
    if [ -n "$TUNNEL_URL" ]; then
        break
    fi
    sleep 1
done

echo "=========================================="
echo "Raw Text Streaming - Maximum Speed!"
echo "Tunnel URL: $TUNNEL_URL/chat"
echo ""
echo "Usage:"
echo "curl -X POST $TUNNEL_URL/chat -H 'Content-Type: application/json' -d '{\"message\":\"Hello!\"}'"
echo ""
echo "With system prompt:"
echo "curl -X POST $TUNNEL_URL/chat -H 'Content-Type: application/json' -d '{\"system\":\"You are helpful\",\"message\":\"What is AI?\"}'"
echo "=========================================="

echo "$TUNNEL_URL" > tunnel_url.txt

# Cleanup
cleanup() {
    echo "Shutting down..."
    kill $TUNNEL_PID $SERVER_PID $OLLAMA_PID 2>/dev/null
    exit 0
}

trap cleanup SIGINT SIGTERM

tail -f tunnel.log