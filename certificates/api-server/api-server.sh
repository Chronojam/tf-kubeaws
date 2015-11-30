IPADDR=$1

# Replace IP addr here.
sed "s#{{ ip_addr }}#$IPADDR#g" openssl.cnf > $IPADDR-openssl.cnf

openssl genrsa -out $IPADDR-apiserver-key.pem 2048
openssl req -new -key $IPADDR-apiserver-key.pem -out $IPADDR-apiserver.csr -subj "/CN=kube-controller" -config $IPADDR-openssl.cnf
openssl x509 -req -in $IPADDR-apiserver.csr -CA ../ca/ca.pem -CAkey ../ca/ca-key.pem -CAcreateserial -out $IPADDR-apiserver.pem -days 86400 -extensions v3_req -extfile $IPADDR-openssl.cnf
