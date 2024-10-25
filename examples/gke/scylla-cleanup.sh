#!/bin/bash
set -e

echo "Starting deletion of Scylla-related resources in the cluster..."
kubectl delete namespace scylla-operator --ignore-not-found
kubectl get clusterrole | grep scylla | awk '{print $1}' | xargs -r kubectl delete clusterrole
kubectl get clusterrolebinding | grep scylla | awk '{print $1}' | xargs -r kubectl delete clusterrolebinding
kubectl get crd | grep scylla | awk '{print $1}' | xargs -r kubectl delete crd
kubectl get validatingwebhookconfigurations | grep scylla | awk '{print $1}' | xargs -r kubectl delete validatingwebhookconfigurations
kubectl get mutatingwebhookconfigurations | grep scylla | awk '{print $1}' | xargs -r kubectl delete mutatingwebhookconfigurations
kubectl get configmap --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete configmap {}
kubectl get secret --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete secret {}

# Additional cleanup for deployments, statefulsets, pods, and services
kubectl get deployment --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete deployment {}
kubectl get statefulset --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete statefulset {}
kubectl get pod --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete pod {}
kubectl get svc --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete svc {}

echo "All Scylla-related resources have been deleted."
