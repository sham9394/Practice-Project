🚀 Multi-Server DevOps Deployment Guide
🖥️ Server Overview
Server	Purpose	Role
Server 1	Jenkins + Ansible Control Node	CI/CD + Configuration
Server 2	Kubernetes Master	Cluster Control Plane
Server 3	Kubernetes Worker	Application Node
(Optional) Server 4	Prometheus + Grafana	Observability & Monitoring
🧩 Step-by-Step Execution Plan
🧱 Step 1: Infrastructure Setup (Terraform)

Run on: Local system (or Jenkins server if automated)
Goal: Create 3 EC2 instances and one VPC (public network).

Actions:

Install Terraform on your local system.

Write Terraform code to create:

1 VPC

1 Public Subnet

1 Security Group (open ports 22, 80, 8080, 3000, 9090, 6443, etc.)

3 EC2 Instances (Ubuntu preferred)

Commands:
terraform init
terraform plan
terraform apply -auto-approve


✅ After successful apply, note the public IPs of all three servers.

⚙️ Step 2: Configure Infrastructure using Ansible

Run on: Server 1 (Jenkins + Ansible)
Goal: Install Docker, Kubernetes components, and set up the cluster.

Actions:

SSH into Server 1:

ssh ubuntu@<server1-ip>


Install Ansible and Jenkins (install Ansible first).

Create an Ansible inventory file:

[master]
<master-ip> ansible_user=ubuntu

[worker]
<worker-ip> ansible_user=ubuntu


Write an Ansible playbook to:

Install Docker & Kubernetes packages on both nodes

Initialize Kubernetes cluster on master

Join worker using kubeadm token

Run playbook:
ansible-playbook setup-k8s.yml -i inventory

Verify cluster:
kubectl get nodes

🚀 Step 3: Jenkins CI/CD Deployment

Run on: Server 1 (Jenkins)
Goal: Automate application deployment on the Kubernetes cluster.

Actions:

Install Jenkins (if not already done).

Install required Jenkins plugins:

Git

Docker

Kubernetes CLI

Create a Jenkins pipeline that:

Pulls code from GitHub (Node.js or Python app)

Builds and pushes a Docker image to Docker Hub

Applies Kubernetes manifests using kubectl apply -f deployment.yml

Test by making a code change — Jenkins should auto-deploy to Kubernetes.

📊 Step 4: Monitoring Setup (Prometheus + Grafana)

Run on: Server 4 (optional) or Kubernetes Master
Goal: Monitor Jenkins and Kubernetes metrics.

Actions:

Deploy Prometheus and Grafana using Helm or YAML manifests.

Expose Grafana Dashboard.

Add data sources:

Prometheus → Kubernetes metrics

Node Exporter → Jenkins & system metrics

Create dashboards for:

Cluster CPU & Memory

Pod status

Node health

🔍 Summary — Who Does What
Step	Server	Tools Used	Purpose
1	Local / Jenkins	Terraform	Create EC2 instances
2	Jenkins + Ansible (Server 1)	Ansible	Configure Kubernetes Cluster
3	Jenkins (Server 1)	Jenkins + Docker + Git	CI/CD Deployment
4	Master or Monitoring Node	Prometheus + Grafana	Monitoring & Observabilityyes
