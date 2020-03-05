#!/bin/bash

set -euo pipefail

kubectl run --rm -it \
  --generator=run-pod/v1 \
  --image google/cloud-sdk:slim \
  --serviceaccount cnrm-controller-manager \
  --namespace cnrm-system \
  workload-identity-test
