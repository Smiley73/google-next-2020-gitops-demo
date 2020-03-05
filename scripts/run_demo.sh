#!/bin/bash

set -euo pipefail

echo "Using GCP project '${PROJECT_ID}'"

clear
echo "Here are the current resources, nothing with 'next-gitops-demo' in the name should exist..."

echo -e "\ngcloud compute networks list"
gcloud compute networks list

echo -e "\ngcloud compute firewall-rules list"
gcloud compute firewall-rules list


echo -e "Create the Eunomia GitOpsConfig for the demo"
read -n 1 -s -r -p "Press any key to continue"; clear

# create the namespace and GitOpsConfig CR
helm template templates/eunomia-cr/ -f configs/demo/networks.yaml \
  --set projectName="${PROJECT_ID}" \
  --set git.uri="${URI}" \
  --set git.ref="${REF}" \
  | kubectl apply -f -

echo -e "\nSometimes we have timing issue with the namespace creation, so we're just going to run this twice...\n"
helm template templates/eunomia-cr/ -f configs/demo/networks.yaml \
  --set projectName="${PROJECT_ID}" \
  --set git.uri="${URI}" \
  --set git.ref="${REF}" \
  | kubectl apply -f -

# create the google config connector CRs
#helm template templates/google-config-connector/ -f configs/demo/networks.yaml \
#  | kubectl apply -f -
#helm template templates/google-config-connector/ -f configs/demo/instances.yaml \
#  | kubectl apply -f -

echo -e "\n"
# Restart Eunomia
kubectl delete pods --all -n eunomia-operator

echo "Waiting for the Eunomia pod to restart"
while [[ $(kubectl get pods -l name=eunomia-operator -n eunomia-operator -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo -n "." && sleep 1; done
echo

echo -e "\n\nView the available GitOpsConfigs on this cluster"
read -n 1 -s -r -p "Press any key to continue"; clear
kubectl get gitopsconfigs --all-namespaces

echo -e "\n\nTake a look at the GitOpsConfig for this demo"
read -n 1 -s -r -p "Press any key to continue"; clear
kubectl describe gitopsconfigs -n next-gitops-demo

echo -e "\n\nTake a look at how the Eunomia job is doing"
read -n 1 -s -r -p "Press any key to continue"; clear
echo "Jobs"
kubectl get jobs -n next-gitops-demo
echo "Pods"
kubectl get pods -n next-gitops-demo

echo -e "\n\nTake a look at what has been created through GitOps leveraging Kohl's Eunomia and Google's Config Connector"
read -n 1 -s -r -p "Press any key to continue"; clear
echo "gcloud compute networks list"
gcloud compute networks list

echo "gcloud compute firewall-rules list"
gcloud compute firewall-rules list

echo -e "\ngcloud compute instances list"
gcloud compute instances list

echo -e "\n\nOpen a new shell and execute: ./scripts/run_ping.sh"
echo -e "\n\nThis will log into host 1 via SSH and ping host 2"
echo -e ""

read -n 1 -s -r -p "Press any key to continue AFTER the ping is responding AND leave it running"; clear
./scripts/break_firewall_rules.sh

echo -e "\n\nGo back to the ping and watch it for a bit"
sleep 5
read -n 1 -s -r -p "Press any key to continue AFTER the ping is failing"; clear

echo -e "\ngcloud compute firewall-rules list"
gcloud compute firewall-rules list
echo -e "\nHmm... where did our firewall rule for ICMP go?"
sleep 1
echo -e "\nI'm just glad we manage these rules via Google's Config Connector!!!!"
sleep 1
echo -e "\nSince we don't want to wait 10 minutes, lets just restart the pod to save some time"

./scripts/restart_config_connector.sh

echo -e "\n\nGo back to the ping and watch it for a bit"
sleep 5
read -n 1 -s -r -p "Press any key to continue AFTER the ping is working again"; clear

echo -e "There you go! GitOps and drift management in action!"
echo -e "\nThe demo is done, now it's time to clean up everything!\n\n"

read -n 1 -s -r -p "To remove the demo namespace and GCP resources simply press any key or ctrl-c to cancel and keep everything"; clear
echo -e "Deleting the GCP resource might take a little while. Let this finish please...\n"
kubectl delete namespace next-gitops-demo

echo -e "\n\nEverything should be gone now"

echo "gcloud compute networks list"
gcloud compute networks list

echo -e "\ngcloud compute firewall-rules list"
gcloud compute firewall-rules list

echo -e "\ngcloud compute instances list"
gcloud compute instances list

echo -e "\nThe End\n"
