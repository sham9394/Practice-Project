Prometheus Deployment

kubectl apply -f prometheus-config.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-service.yaml

Verify Prometheus

kubectl get pods -n monitoring
kubectl get svc -n monitoring

You’ll see a NodePort (e.g., 30000).
Access Prometheus at:
👉 http://<any-node-public-ip>:30000

Grafana Deployment

kubectl apply -f grafana-deployment.yaml
kubectl apply -f grafana-service.yaml

Access Grafana

Open:
http://<any-node-public-ip>:32000
Default login:
Username: admin
Password: admin

Add Prometheus as Data Source

In Grafana:
Go to Settings → Data Sources → Add data source
Choose Prometheus
URL: http://prometheus-service.monitoring.svc.cluster.local:9090
Save & Test ✅

Import Dashboards

Grafana has prebuilt dashboards for:
Kubernetes Cluster (ID: 315)
Node Exporter Full (ID: 1860)

Jenkins metrics (if integrated via plugin)
To import:
In Grafana → “+” → Import
Enter Dashboard ID (e.g., 315)
Click “Load”
Select Prometheus data source

💡 (Optional) Monitor Jenkins

You can expose Jenkins metrics too:
Install the Prometheus Metrics Plugin in Jenkins
Manage Jenkins → Plugins → “Prometheus metrics”
Jenkins metrics endpoint:
http://<jenkins-ip>:8080/prometheus

Add this in Prometheus config:

- job_name: 'jenkins'
  static_configs:
    - targets: ['<jenkins-ip>:8080']


Restart Prometheus pod:
kubectl delete pod -n monitoring -l app=prometheus

✅ Final Output
You’ll have:
Prometheus collecting cluster & Jenkins metrics
Grafana visualizing:
Node CPU, RAM, disk usage
Pod status
Jenkins performance