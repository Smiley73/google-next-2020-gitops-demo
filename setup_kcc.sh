#!/bin/bash

set -euo pipefail

# Nothing special here. We're just automatically setting up the requirements as documented by Google:
# https://cloud.google.com/config-connector/docs/how-to/install-upgrade-uninstall

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID}

gcloud container clusters get-credentials next-gitops-demo --zone us-central1-a --project ${PROJECT_ID}

# Download Google Config Connector
mkdir -p tmp
gsutil cp gs://cnrm/latest/release-bundle.tar.gz tmp/release-bundle.tar.gz
tar zxvf tmp/release-bundle.tar.gz -C tmp/
sed -i.bak "s/\${PROJECT_ID?}/${PROJECT_ID}/" tmp/install-bundle-workload-identity/0-cnrm-system.yaml

# Instal the operator for workload identity
kubectl apply -f tmp/install-bundle-workload-identity/

kubectl get pods --all-namespaces
