#!/bin/bash
# Install Node.js + npm
# Install pm2 globally
# Start the app using pm2
# Run on EC2 boot automatically

# Update system
yum update -y

# Install Node.js (Amazon Linux 2)
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git

# Install PM2 globally
npm install -g pm2

# Clone your app repo (only on first boot)
if [ ! -d "/home/ec2-user/app" ]; then
  cd /home/ec2-user
  git clone https://github.com/heroku/node-js-sample.git app
  cd app
  npm install
  pm2 start index.js --name app
  pm2 startup systemd
  pm2 save
fi
