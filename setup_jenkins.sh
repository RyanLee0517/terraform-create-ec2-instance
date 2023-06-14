#!/bin/bash

yum update -y
yum upgrade -y

# Install git for clone docker compose
# yum install git -y

# install docker
yum install docker -y
systemctl enable docker.service
systemctl start docker.service

# install docker-compose
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
chmod -v +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker run --name jenkins \
    -p 80:8080 \
    -p 50000:50000 \
    -v ~/jenkins:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/bin/docker:/usr/bin/docker \
    --privileged \
    --user root \
    --restart always \
    jenkins/jenkins:lts

# git clone https://github.com/ducluanxutrieu/docker-compose-setup.git
# cd docker-compose-setup
# docker-compose -f docker-compose-jenkins up -d

# yum install -y httpd.x86_64
# yum install ec2-instance-connect
# systemctl start httpd.service
# systemctl enable httpd.service
# echo ?Hello World from $(hostname -f)? > /var/www/html/index.html