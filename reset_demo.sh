#!/bin/bash

set -euo pipefail

# Nothing special here. We're just automatically setting up the requirements as documented by Eunomia:
# https://github.com/KohlsTechnology

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID}

gcloud container clusters get-credentials next-gitops-demo --zone us-central1-a --project ${PROJECT_ID}

mkdir -p tmp

# Remove the namespace and everything in it
helm template templates/eunomia-cr/ --set projectName="${PROJECT_ID}" --set git.uri="${URI}" --set git.ref="${REF}" | kubectl delete -f -

# Restart Eunomia
kubectl deleted pods --all -n eunomia-operator
