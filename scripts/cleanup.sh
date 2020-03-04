#!/bin/bash

rm -rf tmp

gcloud config set project ${PROJECT_ID}

gcloud container clusters get-credentials next-gitops-demo --zone us-central1-a --project ${PROJECT_ID}
kubectl delete namespace next-gitops-demo

# nuke the GKE cluster
gcloud container clusters delete next-gitops-demo --quiet --zone=us-central1-a

# let's leave the SA for now, others might be using the same GCP project
# gcloud iam service-accounts delete cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com --quiet
