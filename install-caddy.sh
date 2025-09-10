#!/usr/bin/env bash
set -e

# === Caddy 安装脚本 for Debian 12 ===
# 作者: kosnode
# 用法: bash <(curl -fsSL cdy.kosno.de)

echo "[INFO] Updating system packages..."
sudo apt update -y

echo "[INFO] Installing dependencies..."
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl gnupg lsb-release

echo "[INFO] Adding Caddy GPG key..."
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
  | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

echo "[INFO] Adding Caddy APT repository..."
CODENAME=$(lsb_release -sc)
echo "deb [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] \
  https://dl.cloudsmith.io/public/caddy/stable/deb/debian \
  ${CODENAME} main" \
  | sudo tee /etc/apt/sources.list.d/caddy-stable.list > /dev/null

echo "[INFO] Updating APT cache..."
sudo apt update -y

echo "[INFO] Installing Caddy..."
sudo apt install -y caddy

echo "[INFO] Enabling Caddy to start on boot..."
sudo systemctl enable caddy

echo "[INFO] Starting Caddy service..."
sudo systemctl start caddy

echo "[SUCCESS] Caddy installation completed!"
echo "         You can check status with: sudo systemctl status caddy"
echo "         Default web root: /var/www/html"
echo "         Config file: /etc/caddy/Caddyfile"
