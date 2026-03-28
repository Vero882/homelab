#!/bin/bash

# kubectl cp <namespace>/<pod-name>:<source-path> <local-destination-path>

# This script is used to migrate data out of a pod, and into a local directory.

# source envs
#source .backup-env
set -euo pipefail

# create folders if they don't exist
mkdir -p ./abs/config ./abs/audiobooks ./abs/meta ./linkding ./utk ./n8n

# vars
export ABS_POD=$(kubectl get pod -n audiobookshelf -l app=audiobookshelf -o jsonpath="{.items[0].metadata.name}")
export LINKDING_POD=$(kubectl get pod -n linkding -l app=linkding -o jsonpath="{.items[0].metadata.name}")
export UTK_POD=$(kubectl get pod -n uptimekuma -l app=uptimekuma -o jsonpath="{.items[0].metadata.name}")
export N8N_POD=$(kubectl get pod -n n8n -l app=n8n -o jsonpath="{.items[0].metadata.name}")

# audiobookshelf
echo "Exporting audiobookshelf config..."
kubectl cp audiobookshelf/${ABS_POD}:/config ./abs/config/
echo "Complete."
echo "Exporting audiobookshelf audiobooks.."
kubectl cp audiobookshelf/${ABS_POD}:/audiobooks ./abs/audiobooks/
echo "Complete."
echo "Exporting audiobookshelf metadata.."
kubectl cp audiobookshelf/${ABS_POD}:/metadata ./abs/meta/
echo "Complete."

# linkding
echo "Exporting linkding data..."
kubectl cp linkding/${LINKDING_POD}:/etc/linkding/data ./linkding/
echo "Complete."

# uptimekuma
echo "Exporting uptimekuma data..."
kubectl cp uptimekuma/${UTK_POD}:/app/data ./utk/
echo "Complete."

# n8n
echo "Exporting n8n data..."
kubectl cp n8n/${N8N_POD}:/home/node/.n8n ./n8n/
echo "Complete."
