#!/bin/bash

# Nuke the namespace
kubectl delete namespace next-gitops-demo

SCRIPTDIR=${0%/*}

# Restart the Pods
${SCRIPTDIR}/restart_config_connector copy.sh
${SCRIPTDIR}/restart_eunomia copy.sh
