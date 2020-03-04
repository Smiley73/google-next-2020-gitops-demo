#!/bin/bash

# Nothing special here. We're just automatically setting up the requirements as documented by Eunomia:
# https://github.com/KohlsTechnology

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID} || exit 1

gcloud compute firewall-rules delete next-gitops-demo-1-allow-icmp -q
