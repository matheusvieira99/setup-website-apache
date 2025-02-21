#!/bin/bash

LOG_FILE="/var/log/setup.log"
exec &> >(tee -a "$LOG_FILE")

echo "Updating package list..."
sudo apt-get update

echo "Installing required packages..."
sudo apt-get install -y apache2 git curl

echo "Removing old site folder (if exists)..."
CLONE_DIR="/var/www/html/site"
sudo rm -rf "$CLONE_DIR"

echo "Cloning GitHub repository..."
REPO_URL="https://github.com/matheusvieira99/websitecompleted.git"
sudo git clone "$REPO_URL" "$CLONE_DIR"

echo "Setting up the website in Apache..."
sudo chown -R www-data:www-data "$CLONE_DIR"
sudo chmod -R 755 "$CLONE_DIR"

echo "Restarting Apache..."
sudo systemctl restart apache2

echo "Sending POST request..."
curl -X POST -d "nome=Matheus de Paula Vieira" https://difusaotech.com.br/lab/aws/index.php

echo "Script successfully executed!"