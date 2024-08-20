#!/bin/bash

# Function to check if Helm release exists
check_release_status() {
    helm status flame-node --namespace "$namespace" > /dev/null 2>&1
    echo $?
}

# Function to update Helm dependencies only if required
update_dependencies() {
    echo "Updating dependencies..."
    helm dependency update
}

# Function to select a Kubernetes context
select_k8s_context() {
    contexts=($(kubectl config get-contexts -o name))
    
    if [ ${#contexts[@]} -eq 1 ]; then
        k8s_context="${contexts[0]}"
        echo "Only one context available, automatically selecting: $k8s_context"
    else
        current_context=$(kubectl config current-context)
        echo "Available contexts:"
        for i in "${!contexts[@]}"; do
            if [ "${contexts[i]}" == "$current_context" ]; then
                echo "$((i+1))) ${contexts[i]} (current)"
            else
                echo "$((i+1))) ${contexts[i]}"
            fi
        done
        read -p "Enter the number corresponding to the context to use (default is $current_context): " context_number
        context_number=${context_number:-0}

        if [ "$context_number" -eq 0 ]; then
            k8s_context="$current_context"
        else
            k8s_context="${contexts[$((context_number-1))]}"
        fi
    fi

    kubectl config use-context "$k8s_context"
    echo "Switched to context: $k8s_context"
}

# Function to select a values file
select_values_file() {
    values_files=($(ls values*.yaml))
    
    if [ ${#values_files[@]} -eq 1 ]; then
        values_file="${values_files[0]}"
        echo "Only one values file found, automatically selecting: $values_file"
    else
        echo "Available values files:"
        for i in "${!values_files[@]}"; do
            if [ "$i" -eq 0 ]; then
                echo "$((i+1))) ${values_files[i]} (default)"
            else
                echo "$((i+1))) ${values_files[i]}"
            fi
        done
        read -p "Enter the number corresponding to the values file to use (default is 1): " values_option
        values_option=${values_option:-1}

        values_file="${values_files[$((values_option-1))]}"
    fi

    echo "Using values file: $values_file"
}

# Function to delete all PVCs in the namespace if requested
delete_volumes() {
    read -p "Do you want to delete all PersistentVolumeClaims (PVCs) in the namespace '$namespace'? (y/n): " delete_pvcs
    if [[ "$delete_pvcs" =~ ^[Yy]$ ]]; then
        kubectl delete pvc --all --namespace "$namespace"
        echo "All PVCs in namespace '$namespace' deleted."
    else
        echo "PVCs retained."
    fi
}

# Select Kubernetes context
select_k8s_context

# Get namespace from command line argument or user input
namespace=${1:-}
if [ -z "$namespace" ]; then
    read -p "Enter namespace (default is 'default'): " namespace
fi
namespace=${namespace:-default}

# Determine available actions based on Helm release status
release_status=$(check_release_status)
available_actions=()

if [ "$release_status" -ne 0 ]; then
    available_actions+=("install")
else
    available_actions+=("upgrade" "uninstall")
fi

# Get action from command line argument or user input
action=${2:-}
if [ -z "$action" ]; then
    echo "Available actions:"
    for i in "${!available_actions[@]}"; do
        echo "$((i+1))) ${available_actions[i]}"
    done
    read -p "Enter the number corresponding to the action to perform (default is 1): " action_number
    action_number=${action_number:-1}
    action="${available_actions[$((action_number-1))]}"
fi

# If the action is not uninstall, select a values file
if [ "$action" != "uninstall" ]; then
    select_values_file
fi

# Validate and perform the selected action
if [[ " ${available_actions[*]} " == *" $action "* ]]; then
    case $action in
        install)
            update_dependencies
            helm install flame-node . --namespace "$namespace" --create-namespace -f "$values_file"
            ;;
        upgrade)
            update_dependencies
            helm upgrade flame-node . --namespace "$namespace" --create-namespace -f "$values_file"
            ;;
        uninstall)
            helm uninstall flame-node --namespace "$namespace"
            delete_volumes
            ;;
        *)
            echo "Invalid action. Please enter one of the following: ${available_actions[*]}"
            ;;
    esac
else
    echo "Invalid action. Please enter one of the following: ${available_actions[*]}"
fi
