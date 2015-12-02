#!/bin/bash

# Messy, but it works so whatever.

ip_addr=$1
ip_addr_f=${ip_addr//"."/"_"}
name="worker_$ip_addr_f"
CA_CERT_PATH='../certificates/ca.pem'
CA_KEY_PATH='../certificates/ca-key.pem'

# Certificate Generation
sed "s#{{ ip_addr }}#$ip_addr#g" templates/openssl.cnf > _$ip_addr_f\_openssl.cnf

openssl genrsa -out _$ip_addr_f\_worker_key.pem 2048
openssl req -new -key _$ip_addr_f\_worker_key.pem -out _$ip_addr_f\_worker.csr -subj "/CN=kube-worker"
openssl x509 -req -in _$ip_addr_f\_worker.csr -CA $CA_CERT_PATH -CAkey $CA_KEY_PATH -CAcreateserial -out _$ip_addr_f\_worker.pem -days 86400 -extensions v3_req -extfile _$ip_addr_f\_openssl.cnf

worker_cert=$(cat _$ip_addr_f\_worker.pem |base64 |sed ':a;N;$!ba;s/\n//g')
worker_key=$(cat _$ip_addr_f\_worker_key.pem |base64 |sed ':a;N;$!ba;s/\n//g')
ca_cert=$(cat $CA_CERT_PATH |base64 |sed ':a;N;$!ba;s/\n//g')

cat config/worker.yml | \
  sed -e "s#{{ ca_cert }}#$ca_cert#g" | \
  sed -e "s#{{ worker_cert }}#$worker_cert#g" | \
  sed -e "s#{{ worker_key }}#$worker_key#g" | \
  sed -e "s#{{ artifact_url }}#$artifact_url#g" >> _$ip_addr_f\_userdata.yml

template=$(cat templates/_worker_instance_template| \
  sed -e "s#{{ ip_addr }}#$ip_addr#g" | \
  sed -e "s#{{ ip_addr_f }}#$ip_addr_f#g"| \
  sed -e "s#{{ name }}#$name#g" | \
  sed -e "s#{{ user_data }}#$user_data#g")

echo "$template" > _$ip_addr_f\_worker.tf
