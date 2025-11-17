#!/bin/bash
set -e

echo "=== Updating system ==="
sudo apt update -y
sudo apt upgrade -y

echo "=== Installing base dependencies ==="
sudo apt install -y software-properties-common curl gnupg

echo "=== Installing Ansible ==="
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

echo "=== Installing Java 21 ==="
sudo apt install -y openjdk-21-jdk

echo "=== Adding Jenkins repository ==="
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | sudo tee /usr/share/keyrings/jenkins-keyring.asc >/dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list >/dev/null

echo "=== Installing Jenkins ==="
sudo apt update -y
sudo apt install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "=== Jenkins Status ==="
sudo systemctl status jenkins | grep Active

echo "=== Initial Admin Password ==="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "=== Installation Complete ==="
