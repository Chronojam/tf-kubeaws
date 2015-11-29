openssl genrsa -out admin-key.pem 2048
openssl req -new -key admin-key.pem -out admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in admin.csr -CA ../ca/ca.pem -CAkey ../ca/ca-key.pem -CAcreateserial -out admin.pem -days 86400
