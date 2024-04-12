# Update helm dependencies
helm dependency update .

# Get namespace from command line argument or user input
namespace=${1:-}
if [ -z "$namespace" ]; then
    read -p "Enter namespace (default is 'default'): " namespace
fi
namespace=${namespace:-default}

kubectl get namespace $namespace > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Namespace does not exist. Creating..."
    kubectl create namespace $namespace
fi

# Get action from command line argument or user input
action=${2:-}
if [ -z "$action" ]; then
    read -p "Enter action (install, upgrade, uninstall): " action
fi

case $action in
    install)
        helm install flame-node . --namespace $namespace
        ;;
    upgrade)
        helm upgrade flame-node . --namespace $namespace
        ;;
    uninstall)
        helm uninstall flame-node --namespace $namespace
        ;;
    *)
        echo "Invalid action. Please enter 'install', 'upgrade', or 'uninstall'."
        ;;
esac