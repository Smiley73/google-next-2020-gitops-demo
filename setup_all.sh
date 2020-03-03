#!/bin/bash

set -euo pipefail

./setup_sa.sh
./setup_gke.sh
./setup_kcc.sh
./setup_eunomia.sh

kubectl get pods --all-namespaces
