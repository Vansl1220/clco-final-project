#!/bin/bash
apt-get update -y
apt-get install nginx -y

# Create a simple HTML page
echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/templates/index.html

systemctl enable nginx
systemctl start nginx
