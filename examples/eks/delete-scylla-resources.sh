#!/bin/bash

# Ensure we exit the script if any command fails
set -e

echo "Starting deletion of Scylla-related resources in the cluster..."

# 1. Delete Scylla-related namespace
echo "Deleting Scylla namespace if exists..."
kubectl delete namespace scylla-operator --ignore-not-found

# 2. Delete ClusterRoles related to Scylla
echo "Deleting Scylla-related ClusterRoles..."
kubectl get clusterrole | grep scylla | awk '{print $1}' | xargs -r kubectl delete clusterrole

# 3. Delete ClusterRoleBindings related to Scylla
echo "Deleting Scylla-related ClusterRoleBindings..."
kubectl get clusterrolebinding | grep scylla | awk '{print $1}' | xargs -r kubectl delete clusterrolebinding

# 4. Delete CustomResourceDefinitions (CRDs) related to Scylla
echo "Deleting Scylla-related CRDs..."
kubectl get crd | grep scylla | awk '{print $1}' | xargs -r kubectl delete crd

# # 5. Delete Scylla Deployments in all namespaces
# echo "Deleting Scylla-related Deployments..."
# kubectl get deployment --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete deployment {}

# # 6. Delete Scylla StatefulSets in all namespaces
# echo "Deleting Scylla-related StatefulSets..."
# kubectl get statefulset --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete statefulset {}

# # 7. Delete Scylla Pods in all namespaces
# echo "Deleting Scylla-related Pods..."
# kubectl get pod --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete pod {}

# # 8. Delete Scylla Services in all namespaces
# echo "Deleting Scylla-related Services..."
# kubectl get svc --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete svc {}

# 9. Delete ValidatingWebhookConfigurations related to Scylla
echo "Deleting Scylla-related ValidatingWebhookConfigurations..."
kubectl get validatingwebhookconfigurations | grep scylla | awk '{print $1}' | xargs -r kubectl delete validatingwebhookconfigurations

# 10. Delete MutatingWebhookConfigurations related to Scylla
echo "Deleting Scylla-related MutatingWebhookConfigurations..."
kubectl get mutatingwebhookconfigurations | grep scylla | awk '{print $1}' | xargs -r kubectl delete mutatingwebhookconfigurations

# 11. Delete ConfigMaps related to Scylla in all namespaces
echo "Deleting Scylla-related ConfigMaps..."
kubectl get configmap --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete configmap {}

# 12. Delete Secrets related to Scylla in all namespaces
echo "Deleting Scylla-related Secrets..."
kubectl get secret --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete secret {}

# # 13. Delete any remaining Scylla-related resources
# echo "Deleting any remaining Scylla-related resources (Pods, Services, etc.)..."
# kubectl get all --all-namespaces | grep scylla | awk '{print $2 " --namespace=" $1}' | xargs -r -I {} kubectl delete {}

echo "All Scylla-related resources have been deleted."
