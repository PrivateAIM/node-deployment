#!/bin/bash

# Define namespace, use default if not set
NAMESPACE=${NAMESPACE:-default}
NAMESPACE=flame

#setup node-result-service
cd node-result-service

kubectl create configmap result-service-env --from-env-file=.env -n $NAMESPACE

kubectl apply -f . -n $NAMESPACE

cd ..
cd node-hub-api-adapter

kubectl apply -f . -n $NAMESPACE
#kubectl create configmap keycloak-env --from-env-file=.env -n $NAMESPACE
#kubectl apply -f . -n $NAMESPACE
