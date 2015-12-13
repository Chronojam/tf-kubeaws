#!/bin/bash

# Messy, but it works so whatever.

ip_addr=$1
ip_addr_f=${ip_addr//"."/"_"}
name="controller_$ip_addr_f"
CA_CERT_PATH='../certificates/ca.pem'
CA_KEY_PATH='../certificates/ca-key.pem'

# Certificate Generation
sed "s#{{ ip_addr }}#$ip_addr#g" templates/openssl.cnf > _$ip_addr_f\_openssl.cnf

openssl genrsa -out _$ip_addr_f\_controller_key.pem 2048
openssl req -new -key _$ip_addr_f\_controller_key.pem -out _$ip_addr_f\_controller.csr -subj "/CN=kube-controller"
openssl x509 -req -in _$ip_addr_f\_controller.csr -CA $CA_CERT_PATH -CAkey $CA_KEY_PATH -CAcreateserial -out _$ip_addr_f\_controller.pem -days 86400 -extensions v3_req -extfile _$ip_addr_f\_openssl.cnf

controller_cert=$(cat _$ip_addr_f\_controller.pem |base64 |sed ':a;N;$!ba;s/\n//g')
controller_key=$(cat _$ip_addr_f\_controller_key.pem |base64 |sed ':a;N;$!ba;s/\n//g')
ca_cert=$(cat $CA_CERT_PATH |base64 |sed ':a;N;$!ba;s/\n//g')

addresses=$(cat ../etcd_instances/templates/_srv_records|awk '{ print $4 }' | \
  sed 's/.${var.etcd_domain_name}"//g' | \
  sed 's/etcd_//g' | \
  sed 's/_/./g')

etcd_servers=""
for addr in $addresses
do
  if [ -z "$etcd_servers" ]; then
    etcd_servers="http://$addr:2379"
  else
    etcd_servers="$etcd_servers,http://$addr:2379"
  fi
done

cat config/controller.yml | \
  sed -e "s#{{ ca_cert }}#$ca_cert#g" | \
  sed -e "s#{{ controller_cert }}#$controller_cert#g" | \
  sed -e "s#{{ controller_key }}#$controller_key#g" | \
  sed -e "s#{{ artifact_url }}#$artifact_url#g"| \
  sed -e "s#{{ etcd_servers }}#$etcd_servers#g" >> _$ip_addr_f\_userdata.yml

template=$(cat templates/_controller_instance_template| \
  sed -e "s#{{ ip_addr }}#$ip_addr#g" | \
  sed -e "s#{{ ip_addr_f }}#$ip_addr_f#g"| \
  sed -e "s#{{ name }}#$name#g" | \
  sed -e "s#{{ user_data }}#$user_data#g")

echo "$template" > _$ip_addr_f\_controller.tf
