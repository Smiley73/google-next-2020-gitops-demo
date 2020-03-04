#!/bin/bash

# Nothing special here. We're just automatically setting up the requirements as documented by Eunomia:
# https://github.com/KohlsTechnology

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID} || exit 1

gcloud container clusters get-credentials next-gitops-demo --zone us-central1-a --project ${PROJECT_ID}  || exit 1

mkdir -p tmp

# Nuke the namespace
kubectl delete namespace next-gitops-demo

# Restart Eunomia
kubectl delete pods --all -n eunomia-operator
