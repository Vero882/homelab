#!/bin/bash

# kubectl cp <namespace>/<pod-name>:<source-path> <local-destination-path>

# This script is used to migrate data out of a pod, and into a local directory.

# source envs
#source .restore-env

set -euo pipefail

# vars
export ABS_POD=audiobookshelf-restore
export LINKDING_POD=linkding-restore
export UTK_POD=uptimekuma-restore
export N8N_POD=n8n-restore

# wait for ready
kubectl wait --for=condition=Ready pod/audiobookshelf-restore -n audiobookshelf --timeout=120s
kubectl wait --for=condition=Ready pod/linkding-restore -n linkding --timeout=120s
kubectl wait --for=condition=Ready pod/uptimekuma-restore -n uptimekuma --timeout=120s
kubectl wait --for=condition=Ready pod/n8n-restore -n n8n --timeout=120s

# remove default files
echo "Cleaning audiobookshelf..."
kubectl exec -n audiobookshelf ${ABS_POD} -- sh -c "rm -rf /config/* /config/.[!.]* 2>/dev/null || true"
kubectl exec -n audiobookshelf ${ABS_POD} -- sh -c "rm -rf /audiobooks/* /audiobooks/.[!.]* 2>/dev/null || true"
kubectl exec -n audiobookshelf ${ABS_POD} -- sh -c "rm -rf /metadata/* /metadata/.[!.]* 2>/dev/null || true"

echo "Cleaning linkding..."
kubectl exec -n linkding ${LINKDING_POD} -- sh -c "rm -rf /etc/linkding/data/* /etc/linkding/data/.[!.]* 2>/dev/null || true"

echo "Cleaning uptimekuma..."
kubectl exec -n uptimekuma ${UTK_POD} -- sh -c "rm -rf /app/data/* /app/data/.[!.]* 2>/dev/null || true"

echo "Cleaning n8n..."
kubectl exec -n n8n ${N8N_POD} -- sh -c "rm -rf /home/node/.n8n/* /home/node/.n8n/.[!.]* 2>/dev/null || true"
echo "Clean complete."

# audiobookshelf
echo "Restoring audiobookshelf config..."
kubectl cp ./abs/config/. audiobookshelf/${ABS_POD}:/config || {
  echo "Config restore failed."
  exit 1
}
echo "Complete."

echo "Restoring audiobookshelf audiobooks.."
kubectl cp ./abs/audiobooks/. audiobookshelf/${ABS_POD}:/audiobooks || {
  echo "Audiobooks restore failed."
  exit 1
}
echo "Complete."

echo "Restoring audiobookshelf metadata.."
kubectl cp ./abs/meta/. audiobookshelf/${ABS_POD}:/metadata || {
  echo "Metadata restore failed."
  exit 1
}

kubectl exec -n audiobookshelf ${ABS_POD} -- chown -R 1000:1000 /config
kubectl exec -n audiobookshelf ${ABS_POD} -- chown -R 1000:1000 /audiobooks
kubectl exec -n audiobookshelf ${ABS_POD} -- chown -R 1000:1000 /metadata
echo "Complete."

# linkding
echo "Restoring linkding data..."
kubectl cp ./linkding/. linkding/${LINKDING_POD}:/etc/linkding/data || {
  echo "Linkding restore failed."
  exit 1
}

kubectl exec -n linkding ${LINKDING_POD} -- chown -R 33:33 /etc/linkding/data
echo "Complete."

# uptimekuma
echo "Restoring uptimekuma data..."
kubectl cp ./utk/. uptimekuma/${UTK_POD}:/app/data || {
  echo "UptimeKuma restore failed."
  exit 1
}

kubectl exec -n uptimekuma ${UTK_POD} -- chown -R 0:0 /app/data
echo "Complete."

# n8n
echo "Restoring n8n data..."
kubectl cp ./n8n/. n8n/${N8N_POD}:/home/node/.n8n || {
  echo "n8n restore failed."
  exit 1
}

kubectl exec -n n8n ${N8N_POD} -- chown -R 1000:1000 /home/node/.n8n
echo "Restore complete."
