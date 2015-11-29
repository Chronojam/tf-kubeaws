openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -days 86400 -out ca.pem -subj "/CN=kube-ca"
