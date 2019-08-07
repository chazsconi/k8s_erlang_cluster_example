#!/bin/bash
kubectl delete deployment k8s-example-deployment
kubectl delete service k8s-example-service
kubectl delete statefulset k8s-example-statefulset
kubectl delete service k8s-example-erlang-cluster
