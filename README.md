# FLAME Node deployment
The FLAME Node Deployment contains all files to deploy a FLAME Node.

## Table of Contents
- [Software Requirements](#software-requirements)
- [Prerequisites](#prerequisites)
- [Deploy the FLAME Node](#deploy-the-flame-node)
- [Access the FLAME Node](#access-the-flame-node)

## Software Requirements

For the deployment of a FLAME Node, you need to have the following software:

Make sure you have the following installed and setup:
- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) (or a different kubernetes distribution)  
    - For extra security a Network Policy Controller like [Calico](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)


## FLAME Node Setup Overview

To deploy a FLAME Node, you need to follow these steps (details below):
1. Clone the repository, if you haven't already
   - Change into the directory of the repository and navigate to the `flame/` folder
2. Adjust the values in the `values_min.yaml` file to your needs
   - (Optional) Create a copy of the `values_min.yaml` for your own custom values.
   - **NOTE**: The `values.yaml` contains _all_ the available helm chart options and is used for advanced configuration
3. Deploy the Flame Node
   - Using `helm install`
   - Using the provided `0_setup.sh` script  
        - Make the `0_setup.sh` script executable if needed 
        - Select the namespace you want to deploy the node in
        - Select 1 to install the node

## Prerequisites

### Start Minikube (optional)
**NOTE:** This step is only required if you just installed Minikube and are administrating it. 

Start Minikube with the following command:
```bash
minikube start --driver=docker --nodes 1 --memory=8192 --cpus=2 --network-plugin=cni --cni=calico --addons=dashboard --addons=ingress --profile=node1
```

## Deploy the FLAME Node

### 1. Clone the Repo and Navigate to the `flame/` Directory
Clone the repository and change into the directory:
```bash
git clone https://github.com/PrivateAIM/node-deployment.git
cd node-deployment/flame
```

### 2. Copy (optional) and Modify `values_min.yaml`
(Optional) Create a copy of the `values_min.yaml` file:
```bash
cp values_min.yaml values_min_node1.yaml
```

Open the `values_min_node1.yaml` file and modify the values for your installation. At minimum, you will need to 
enter the node robot "ID" and "Secret" for the `robotUser` and `robotSecret` values, respectively. 
These can [obtained from the Hub](https://github.com/PrivateAIM/node-deployment/wiki/Obtaining-Robot-Credentials):

```yaml
global:
  hub:
    endpoints:
      auth: https://auth.privateaim.dev
      core: https://core.privateaim.dev
      messenger: https://messenger.privateaim.dev
      storage: https://storage.privateaim.dev
    auth:
      robotUser: ""      # <-- Modify this line with the robot "ID"
      robotSecret: ""    # <-- Modify this line with the robot "Secret"
```

#### **IMPORTANT**: Adding a Hostname
If you have a hostname that you'd like to use for your instance, change all instances of "localhost" in the values 
file to your hostname. Be sure to leave the text (e.g. "https://") before and after "localhost" the same. Be sure this 
hostname is properly configured in your DNS settings and your reverse proxy to point to your kubernetes cluster.

### 3. Deploy the Flame Node
Initial deployment will take some time (minutes) to pull of the images, execute the jobs, and to populate the containers. Please be patient during the installation process.

Once you have your configured values YAML file, you can perform installation using helm:

```bash
helm dependency build
helm install flame-node . -f values_min_node1.yaml
```

**OR** using the setup script:

```bash
chmod +x 0_setup.sh
bash 0_setup.sh
```
See the [setup script instructions](https://github.com/PrivateAIM/node-deployment/wiki/Setup-Script-Instructions) 
for details on how to use this script.

**NOTE**: The `values_min_node1.yaml` should be substituted with whichever values file you modified with your values.

## Access the FLAME Node
If you did not replace "localhost" in the values file with a hostname, then to access the FLAME Node, 
you need to port-forward the minikube ingress service (or minikube ip) to your local machine:
```bash
kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 80:80
```
Open a browser and navigate to `http://localhost` to access the FLAME Node UI.


