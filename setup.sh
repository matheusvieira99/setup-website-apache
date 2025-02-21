#!/bin/bash

LOG_FILE="/var/log/setup.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "Installing Apache..."
sudo apt-get update
sudo apt-get install -y apache2

echo "Cloning github repo..."
REPO_URL="https://github.com/matheusvieira99/websitecompleted.git"
CLONE_DIR="/var/www/html/site"
sudo git clone $REPO_URL $CLONE_DIR

echo "Seting up the website in Apache..."
sudo chown -R www-data:www-data $CLONE_DIR
sudo chmod -R 755 $CLONE_DIR

echo "Restarting Apache..."
sudo systemctl restart apache2

echo "Sending POST request..."
curl -X POST -d "nome=Matheus de Paula Vieira" https://difusaotech.com.br/lab/aws/index.php

echo "Script successfully executed!"