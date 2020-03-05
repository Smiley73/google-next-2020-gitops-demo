#!/bin/bash

SCRIPTDIR=${0%/*}

set -euo pipefail

${SCRIPTDIR}/configure_env.sh
${SCRIPTDIR}/setup_sa.sh
${SCRIPTDIR}/setup_gke.sh
${SCRIPTDIR}/setup_kcc.sh
${SCRIPTDIR}/setup_eunomia.sh

kubectl get pods --all-namespaces
