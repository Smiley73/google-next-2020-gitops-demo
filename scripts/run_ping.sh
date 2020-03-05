#!/bin/bash

set -euo pipefail

gcloud beta compute ssh --zone "us-central1-a" "next-gitops-instance-1" --tunnel-through-iap --project "${PROJECT_ID}" --command "ping next-gitops-instance-2 -W 1 -O"
