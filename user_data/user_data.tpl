#!/bin/bash

# Install and update packages
amazon-linux-extras install epel -y
yum update -y
yum install stress -y
yum install -y httpd.x86_64

# Get IMDSv2 token (valid for 6 hours / 21600 seconds)
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

# Use the token to get availability zone information
REGION_AV_ZONE=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone`

# Start and enable HTTP service
systemctl start httpd.service
systemctl enable httpd.service

# Create the web page with instance information
echo "Hello World from $(hostname -f) from the availability zone: $REGION_AV_ZONE" > /var/www/html/index.html