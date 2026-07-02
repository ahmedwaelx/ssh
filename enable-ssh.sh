#!/usr/bin/env bash

set -e

echo "Updating package list..."
sudo apt update

echo "Installing OpenSSH Server..."
sudo apt install -y openssh-server

echo "Enabling and starting SSH service..."
sudo systemctl enable --now ssh

echo "Allowing SSH through UFW firewall if enabled..."
if command -v ufw >/dev/null 2>&1; then
    sudo ufw allow OpenSSH || sudo ufw allow 22/tcp
fi

echo "Checking SSH service..."
sudo systemctl is-active --quiet ssh && echo "SSH is running successfully."

echo "Done. You can connect using:"
echo "ssh username@server_ip"
