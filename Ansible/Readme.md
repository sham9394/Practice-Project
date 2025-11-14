ansible-playbook -i inventory.ini install_docker.yml
ansible-playbook -i inventory.ini install_kubernetes.yml
ansible-playbook -i inventory.ini init_master.yml
ansible-playbook -i inventory.ini join_worker.yml


kubectl get nodes
