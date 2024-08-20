# FLAME Node deployment

The FLAME Node Deployment contains all files to deploy a FLAME Node.


## Prerequisites

For the deployment of a FLAME Node, you need to have the following prerequisites installed:

- A running Kubernetes cluster
  - for example, [Minikube](https://minikube.sigs.k8s.io/docs/start/)
  - for extra security a Network Policy Controller like [Calico](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
- Helm
  - installation [Helm](https://helm.sh/docs/intro/install/)


## FLAME Node setup

To deploy a FLAME Node, you need to follow these steps:
 - Clone the repository, if you haven't already,
 - git clone https://github.com/PrivateAIM/node-deployment.git
 - Change into the directory of the repository,
 - go to the directory `Flame`
 - Ajdust the values in the `values.yaml` file to your needs
   - TODO: Add a description of the values
 - make 0_setup.sh executable chmod +x 0_setup.sh
 - Run the setup script `./0_setup.sh`
   - select the namespace you want to deploy the node in
   - select 1 to install the node

## Test deployment with Minikube

### Prerequisites
Make sure you have the following installed:
- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)

### Start Minikube
Start Minikube with the following command:
```bash
minikube start --driver=docker --nodes 1 --memory=8192 --cpus=2 --network-plugin=cni --cni=calico --addons=dashboard --addons=ingress --profile=node1
```

### Deploy the FLAME Node
Clone the repository and change into the directory:
```bash
git clone https://github.com/PrivateAIM/node-deployment.git
cd node-deployment/flame
```

Create a copy of the `values_min.yaml` file:
```bash
  cp values_min.yaml values_min_node1.yaml
```

Open the `values_min_node1.yaml` file and adjust the values to your needs. At least you need to adjust the `nodeId`, `robotUser`, `robotSecret` values.

Run the setup script:
```bash
bash 0_setup.sh
```

### Access the FLAME Node
To access the FLAME Node, you need to port-forward the minikube ingress service (or minikube ip) to your local machine:
```bash
kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 80:80
```
Open a browser and navigate to `http://localhost` to access the FLAME Node UI.


