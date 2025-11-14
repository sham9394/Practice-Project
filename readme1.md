Multi-Server DevOps Deployment Guide


















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


✅ After applying, note the public IPs of the servers.

⚙️ Step 2: Configure Infrastructure using Ansible

Run on: Server 1 (Jenkins + Ansible)
Goal: Install Docker, Kubernetes components, and configure the cluster.

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

Install Docker & Kubernetes packages

Initialize Kubernetes cluster on master

Join worker node using kubeadm token

Run playbook:
ansible-playbook setup-k8s.yml -i inventory

Verify cluster:
kubectl get nodes

🚀 Step 3: Jenkins CI/CD Deployment

Run on: Server 1 (Jenkins)
Goal: Automate application deployment to the Kubernetes cluster.

Actions:

Install Jenkins (if not already installed).

Install the following Jenkins plugins:

Git

Docker

Kubernetes CLI

Create a Jenkins Pipeline that:

Pulls code from GitHub (Node.js / Python app)

Builds and pushes a Docker image to DockerHub

Deploys to Kubernetes using:

kubectl apply -f deployment.yml


Test by committing a code change → Jenkins should automatically build and deploy to Kubernetes.

📊 Step 4: Monitoring Setup (Prometheus + Grafana)

Run on: Server 4 (optional) or Kubernetes Master
Goal: Monitor Jenkins and Kubernetes metrics.

Actions:

Deploy Prometheus and Grafana using Helm or YAML manifests.

Expose the Grafana Dashboard.

Add data sources:

Prometheus → Kubernetes metrics

Node Exporter → Jenkins & system metrics

Create basic dashboards:

Cluster CPU & Memory usage

Pod status

Node health

🔍 Summary — Who Does What
Step	Server	Tools Used	Purpose
1	Local / Jenkins	Terraform	Create EC2 instances
2	Jenkins + Ansible (Server 1)	Ansible	Configure Kubernetes Cluster
3	Jenkins (Server 1)	Jenkins + Docker + Git	CI/CD Deployment
4	Master or Monitoring Node	Prometheus + Grafana	Monitoring & Observability
🏗️ Architecture Diagram (Optional)

You can include a simple diagram like this:

graph TD
    A[Local System / Jenkins] -->|Terraform| B[VPC with EC2 Instances]
    B --> C[Jenkins + Ansible (Server 1)]
    B --> D[K8s Master (Server 2)]
    B --> E[K8s Worker (Server 3)]
    D --> E
    D --> F[(Prometheus + Grafana - Server 4)]
    C -->|CI/CD Pipeline| D
    C -->|Deploys App| E

🧰 Tech Stack

Infrastructure: AWS EC2, VPC, Terraform

Configuration Management: Ansible

Containerization: Docker

Orchestration: Kubernetes (kubeadm setup)

CI/CD: Jenkins

Monitoring: Prometheus, Grafana

Version Control: GitHub

🏁 Final Outcome

✅ Automated provisioning of EC2 instances using Terraform
✅ Kubernetes cluster setup using Ansible
✅ CI/CD pipeline via Jenkins (auto deploys code updates)
✅ Real-time monitoring via Prometheus + Grafana