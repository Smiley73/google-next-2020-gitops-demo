#!/bin/bash

set -euo pipefail

# Make sure we got the service account
if [ -z "$(gcloud iam service-accounts list | grep cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com)" ]; then
  gcloud iam service-accounts create cnrm-system
fi

# Project owner access
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
--member="serviceAccount:cnrm-system@${PROJECT_ID}.iam.gserviceaccount.com" \
--role="roles/owner"
