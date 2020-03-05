#!/bin/bash

echo "Using GCP project '${PROJECT_ID}'"

gcloud config set project ${PROJECT_ID} || exit 1

echo "Using Git Repo: ${URI}"
echo "Using Git Branch: ${REF}"
