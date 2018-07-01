# access k8s from local
scp azureuser@{dnsName}:.kube/config .
$env:KUBECONFIG = "./config"
kubectl get nodes

# run nginx
kubectl run nginx --image nginx

kubectl expose deployment nginx --port=80
# change from ClusterIP to LoadBalancer
kubectl edit svc/nginx

# get public ip address assign
kubectl get services
