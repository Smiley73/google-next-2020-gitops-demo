#!/bin/bash

set -euo pipefail

echo "Using GCP project '${PROJECT_ID}'"
gcloud config set project ${PROJECT_ID}

# Spin up the GKE cluster
gcloud beta container clusters create next-gitops-demo \
  --zone=us-central1-a \
  --machine-type=n1-standard-1 \
  --identity-namespace=${PROJECT_ID}.svc.id.goog \
  --release-channel=stable
#  --preemptible \


# Access for workload identity
gcloud iam service-accounts add-iam-policy-binding \
cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com \
--member="serviceAccount:${PROJECT_ID}.svc.id.goog[cnrm-system/cnrm-controller-manager]" \
--role="roles/iam.workloadIdentityUser"

# Make sure kubectl is configured for us to use the new cluster
gcloud container clusters get-credentials next-gitops-demo \
  --zone us-central1-a --project ${PROJECT_ID}

kubectl get pods --all-namespaces
