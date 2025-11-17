# Kubernetes Cluster Setup (Ansible Automated)  
This project deploys a complete Kubernetes cluster (1 Master + N Workers) on Ubuntu servers using a **single Ansible playbook**.  
It installs containerd, Kubernetes components, initializes the Master node, joins Worker nodes, installs Calico CNI, and verifies the cluster.

---

## 📌 Features
- Fully automated Kubernetes setup  
- Works on any Ubuntu version (20.04 / 22.04 / 24.04)  
- Containerd runtime with SystemdCgroup enabled  
- Automatic API-server cleanup to avoid port 6443 issues  
- Automatic join command distribution to workers  
- Calico CNI installation  
- Final cluster‐ready verification  

---

## 🖥️ Server Inventory
| Server  | Purpose  |
|---------|----------|
| master1 | Kubernetes Control-plane |
| worker1 | Kubernetes Worker Node |

`inventory.ini`
```ini
[master]
master1 ansible_host=IP ansible_user=ubuntu

[worker]
worker1 ansible_host=IP ansible_user=ubuntu

[all:vars]
ansible_python_interpreter=/usr/bin/python3

🚀 How to Run
1️⃣ Install Ansible
sudo apt update
sudo apt install -y ansible

2️⃣ Copy inventory
nano inventory.ini

3️⃣ Run the playbook
ansible-playbook -i inventory.ini k8s-cluster.yml

✔️ Validation

After the playbook completes:

kubectl get nodes -o wide


Expected output:

NAME             STATUS   ROLES           AGE   VERSION
master1          Ready    control-plane   Xs    v1.31.x
worker1          Ready    <none>          Xs    v1.31.x

🧹 Cleanup (Optional)

To reset everything:

kubeadm reset -f
rm -rf /etc/kubernetes /var/lib/kubelet /var/lib/etcd
systemctl restart containerd
