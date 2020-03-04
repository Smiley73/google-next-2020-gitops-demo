#!/bin/bash

set -euo pipefail

# Nothing special here. We're just automatically setting up the requirements as documented by Eunomia:
# https://github.com/KohlsTechnology

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID}

gcloud beta compute ssh --zone "us-central1-a" "next-gitops-instance-1" --tunnel-through-iap --project "kohls-paas-sbx" --command "ping next-gitops-instance-1"
