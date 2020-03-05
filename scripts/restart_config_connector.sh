#!/bin/bash

# Restart Config-Connector
kubectl delete pods cnrm-controller-manager-0 -n cnrm-system
