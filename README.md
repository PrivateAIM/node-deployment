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
