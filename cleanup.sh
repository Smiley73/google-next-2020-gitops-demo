#!/bin/bash

rm -rf tmp

gcloud config set project ${PROJECT_ID}

gcloud container clusters get-credentials gitops-demo --zone us-central1-a --project ${PROJECT_ID}
kubectl delete namespace gcp-gitops-demo

sleep 15

gcloud container clusters delete gitops-demo --quiet --zone=us-central1-a
gcloud iam service-accounts delete cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com --quiet
