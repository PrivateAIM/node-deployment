kubectl create namespace flame

helm repo add kong https://charts.konghq.com
helm repo update



helm install kong kong/kong --values ./values.yaml -n flame