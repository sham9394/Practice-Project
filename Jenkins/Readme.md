sudo usermod -aG docker jenkins
sudo systemctl restart jenkins


scp -i my-key.pem ubuntu@<master_ip>:/home/ubuntu/.kube/config ~/.kube/config
sudo chown jenkins:jenkins ~/.kube/config
