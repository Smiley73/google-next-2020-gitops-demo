#!/bin/bash

set -euo pipefail

# Nothing special here. We're just automatically setting up the requirements as documented by Google:
# https://cloud.google.com/config-connector/docs/how-to/install-upgrade-uninstall

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID}

# Make sure we got the service account
if [ -z "$(gcloud iam service-accounts list | grep cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com)" ]; then
  gcloud iam service-accounts create cnrm-system
fi

# Project owner access
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
--member="serviceAccount:cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/owner"

# Access for workload identity
gcloud iam service-accounts add-iam-policy-binding \
cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com \
--member="serviceAccount:cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/iam.workloadIdentityUser"

# Spin up the GKE cluster
gcloud container clusters create next-gitops-demo \
  --zone=us-central1-a \
  --preemptible \
  --machine-type=n1-standard-1

# Make sure we can log in
gcloud container clusters get-credentials next-gitops-demo --zone us-central1-a --project ${PROJECT_ID}

kubectl get pods --all-namespaces
