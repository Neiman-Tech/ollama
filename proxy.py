#!/usr/bin/env python3
from flask import Flask, request, Response
import requests
import json

app = Flask(__name__)
OLLAMA_URL = "http://localhost:11434"

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json() if request.is_json else {}
    
    message = data.get('message', '')
    system_prompt = data.get('system', '')
    
    if not message:
        return "Error: 'message' field is required", 400
    
    # Build prompt
    prompt = f"{system_prompt}\n\n{message}" if system_prompt else message
    
    # Stream from Ollama and extract only text
    def generate():
        response = requests.post(
            f"{OLLAMA_URL}/api/generate",
            json={
                "model": "llama3.2",
                "prompt": prompt,
                "stream": True
            },
            stream=True
        )
        
        for line in response.iter_lines():
            if line:
                try:
                    json_response = json.loads(line)
                    text = json_response.get('response', '')
                    if text:
                        yield text
                except:
                    pass
    
    return Response(generate(), mimetype='text/plain')

@app.route('/health', methods=['GET'])
def health():
    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)