#!/bin/bash
set -e
echo "LibertyStack — installing your sovereign AI..."
mkdir -p ~/LibertyStack && cd ~/LibertyStack
curl -fsSL https://raw.githubusercontent.com/MarShawns/LibertyStack/main/docker-compose.yml -o docker-compose.yml
docker compose up -d
until curl -s http://localhost:11434 >/dev/null; do sleep 2; done
ollama pull qwen2.5:32b
echo "Installed. Open http://localhost:3000"
open http://localhost:3000 || xdg-open http://localhost:3000 || start http://localhost:3000
