#!/bin/bash

sudo yum update -y && sudo yum install httpd -y  # Update the machine and install apache

sudo sed -i "s/^Listen .*/Listen ${app_port}/" /etc/httpd/conf/httpd.conf  # Change Apache's default listening port to custom_http_port

sudo systemctl enable httpd && sudo systemctl start httpd

cat > /var/www/html/index.html <<EOF
    <html>
        <h1>Hello, World :)</h1>
        <p>Everything is ok</p>
    </html>
EOF