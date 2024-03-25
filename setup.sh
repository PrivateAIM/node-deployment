#!/bin/bash
#setup node-result-service
cd node-result-service

kubectl create configmap result-service-env --from-env-file=.env

kubectl apply -f .

cd ..
cd node-hub-api-adapter

kubectl apply -f .
#kubectl create configmap keycloak-env --from-env-file=.env
#kubectl apply -f .