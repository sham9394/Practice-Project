#!/bin/bash
set -e

echo "Updating system..."
apt update -y

echo "Installing dependencies..."
apt install -y curl wget git software-properties-common gnupg2

# Install Ansible
add-apt-repository --yes --update ppa:ansible/ansible
apt install -y ansible

# Install Jenkins
apt install -y openjdk-17-jdk

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" \
  | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update -y
apt install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# Store Jenkins password
cat /var/lib/jenkins/secrets/initialAdminPassword > /root/jenkins_password.txt
