#!/bin/sh
echo "Setting ERLANG_NAME"

# Used for K8S Deployment
if [ "$CLUSTER_TYPE" = "DEPLOYMENT" ]; then

  export ERLANG_NAME=$(echo $POD_IP | sed 's/\./-/g').${ERLANG_CLUSTER_SERVICE_NAME}.${NAMESPACE}.svc.cluster.local

# Used for K8S Statefulset
elif [ "$CLUSTER_TYPE" = "HARDCODED_STATEFULSET" ] || [ "$CLUSTER_TYPE" = "DISCOVERED_STATEFULSET" ]; then

  export ERLANG_NAME=$(hostname -f)

else
  echo "No CLUSTER_TYPE set"
  exit 1
fi
