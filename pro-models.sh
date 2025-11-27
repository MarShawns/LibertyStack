#!/bin/bash
# LibertyStack Pro Models — $29 one-time unlock for bleeding-edge brains
# Run after base install: ./pro-models.sh YOUR_PRO_KEY

set -e

PRO_KEY=$1
if [ -z "$PRO_KEY" ]; then
  echo "Usage: ./pro-models.sh YOUR_PRO_KEY (get at libertystack.com/pro)"
  exit 1
fi

# Verify key (dummy for now — we'll hook to Stripe/PayPal later)
if [ "$PRO_KEY" != "demo-123" ]; then  # Replace with real validation
  echo "Invalid key. Buy at https://libertystack.com/pro"
  exit 1
fi

echo "Pro unlocked! Downloading frontier models..."

cd ~/LibertyStack

# Pull latest quantized beasts (update these URLs monthly)
curl -L https://huggingface.co/MarShawns/libertystack-pro/resolve/main/deepseek-r1-70b-q4.gguf -o models/deepseek.gguf
curl -L https://huggingface.co/MarShawns/libertystack-pro/resolve/main/llama-3.3-70b-q4.gguf -o models/llama.gguf

# Auto-updater cron (runs weekly, pulls new models)
(crontab -l 2>/dev/null; echo "0 2 * * 0 cd ~/LibertyStack && ./update-models.sh") | crontab -

echo "Pro models live! Restart OpenWebUI: docker compose restart openwebui"
echo "Your AI just got 2x smarter. Enjoy the edge."
