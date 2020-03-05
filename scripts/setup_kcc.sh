#!/bin/bash

set -euo pipefail

# Download Google Config Connector
mkdir -p tmp
gsutil cp gs://cnrm/latest/release-bundle.tar.gz tmp/release-bundle.tar.gz
tar zxvf tmp/release-bundle.tar.gz -C tmp/
sed -i.bak "s/\${PROJECT_ID?}/${PROJECT_ID}/" tmp/install-bundle-workload-identity/0-cnrm-system.yaml

# Instal the operator for workload identity
kubectl apply -f tmp/install-bundle-workload-identity/

kubectl get pods --all-namespaces
