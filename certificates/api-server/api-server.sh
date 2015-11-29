openssl genrsa -out apiserver-key.pem 2048
openssl req -new -key apiserver-key.pem -out apiserver.csr -subj "/CN=*" -config openssl.cnf
openssl x509 -req -in apiserver.csr -CA ../ca/ca.pem -CAkey ../ca/ca-key.pem -CAcreateserial -out apiserver.pem -days 86400 -extensions v3_req -extfile openssl.cnf
