#!/bin/bash
docker build \
  -f deploy/Dockerfile \
  --build-arg APP_NAME=k8s_example \
  --build-arg APP_VSN=0.1.0 \
  --build-arg SKIP_PHOENIX=true \
  -t k8s_example:latest \
  .
