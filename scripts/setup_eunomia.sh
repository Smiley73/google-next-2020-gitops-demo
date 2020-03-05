#!/bin/bash

set -euo pipefail

# check out the Eunomia repo
test -d tmp/eunomia && rm -rf tmp/eunomia
mkdir -p tmp
git clone https://github.com/KohlsTechnology/eunomia.git tmp/eunomia

# Deploy the operator
helm template tmp/eunomia/deploy/helm/eunomia-operator/ | kubectl apply -f -

kubectl get pods --all-namespaces
