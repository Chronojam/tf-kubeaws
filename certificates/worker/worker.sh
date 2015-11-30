IPADDR=$1

# Replace IP addr here.
sed "s#{{ ip_addr }}#$IPADDR#g" openssl.cnf > $IPADDR-openssl.cnf

openssl genrsa -out $IPADDR-worker-key.pem 2048
openssl req -new -key $IPADDR-worker-key.pem -out $IPADDR-worker.csr -subj "/CN=kube-worker"
openssl x509 -req -in $IPADDR-worker.csr -CA ../ca/ca.pem -CAkey ../ca/ca-key.pem -CAcreateserial -out $IPADDR-worker.pem -days 86400 -extensions v3_req -extfile $IPADDR-openssl.cnf
