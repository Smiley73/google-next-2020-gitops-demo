#!/bin/bash

set -euo pipefail

# Nothing special here. We're just automatically setting up the requirements as documented by Eunomia:
# https://github.com/KohlsTechnology

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID}

gcloud container clusters get-credentials next-gitops-demo --zone us-central1-a --project ${PROJECT_ID}

mkdir -p tmp

# Nuke the config connector CRs
helm template templates/google-config-connector/ -f configs/demo/networks.yaml \
  | kubectl delete -f -

# Remove the namespace and everything in it
helm template templates/eunomia-cr/ -f configs/demo/networks.yaml \
  --set projectName="${PROJECT_ID}" \
  --set git.uri="${URI}" \
  --set git.ref="${REF}" \
  | kubectl delete -f -

# Restart Eunomia
kubectl delete pods --all -n eunomia-operator
