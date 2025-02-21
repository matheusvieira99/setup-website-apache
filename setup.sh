#!/bin/bash

LOG_FILE="/var/log/setup.log"
exec &> >(tee -a "$LOG_FILE")

echo "Updating package list..."
sudo yum -y update

echo "Installing required packages..."
sudo yum -y install httpd git curl

echo "Starting and enabling Apache (httpd)..."
sudo systemctl enable httpd
sudo systemctl start httpd

echo "Removing old site folder (if exists)..."
CLONE_DIR="/var/www/html/site"
sudo rm -rf "$CLONE_DIR"

echo "Cloning GitHub repository..."
REPO_URL="https://github.com/matheusvieira99/websitecompleted.git"
sudo git clone "$REPO_URL" "$CLONE_DIR"

echo "Setting up the website in Apache..."
sudo chown -R apache:apache "$CLONE_DIR"
sudo chmod -R 755 "$CLONE_DIR"

echo "Updating SELinux permissions (if enabled)..."
sudo restorecon -R /var/www/html

echo "Restarting Apache..."
sudo systemctl restart httpd

echo "Sending POST request..."
curl -X POST -d "nome=Matheus de Paula Vieira" https://difusaotech.com.br/lab/aws/index.php

echo "Script successfully executed!"