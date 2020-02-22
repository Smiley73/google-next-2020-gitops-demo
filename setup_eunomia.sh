#!/bin/bash

set -euo pipefail

# Nothing special here. We're just automatically setting up the requirements as documented by Google:
# https://cloud.google.com/config-connector/docs/how-to/install-upgrade-uninstall

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID}

gcloud container clusters get-credentials gitops-demo --zone us-central1-a --project ${PROJECT_ID}

mkdir -p tmp
git clone git@github.com:KohlsTechnology/eunomia.git tmp/eunomia

# Deploy the operator
helm template tmp/eunomia/deploy/helm/eunomia-operator/ | kubectl apply -f -

kubectl get pods --all-namespaces
