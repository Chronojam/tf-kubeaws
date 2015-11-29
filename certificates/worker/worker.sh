openssl genrsa -out worker-key.pem 2048
openssl req -new -key worker-key.pem -out worker.csr -subj "/CN=kube-worker"
openssl x509 -req -in worker.csr -CA ../ca/ca.pem -CAkey ../ca/ca-key.pem -CAcreateserial -out worker.pem -days 86400 -extensions v3_req -extfile openssl.cnf
