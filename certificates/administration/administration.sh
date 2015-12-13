#!/bin/bash

openssl genrsa -out admin-key.pem 2048
openssl req -new -key admin-key.pem -out admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in admin.csr -CA ../ca.pem -CAkey ../ca-key.pem -CAcreateserial -out admin.pem -days 86400


cluster_endpoint=$1
admin_key_path=$(realpath admin-key.pem)
admin_cert_path=$(realpath admin.pem)
ca_cert_path=$(realpath ../ca.pem)

cat templates/kubeconfig | \
  sed "s#{{ cluster_endpoint }}#$cluster_endpoint#g"| \
  sed "s#{{ admin_key }}#$admin_key_path#g" | \
  sed "s#{{ admin_cert }}#$admin_cert_path#g" | \
  sed "s#{{ ca_cert }}#$ca_cert_path#g"  >> kubeconfig_$cluster_endpoint
