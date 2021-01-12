# Generate server key and CSR
openssl req -newkey rsa:4096 -nodes -keyout chipper-key.pem -out server-req.pem -config chp_san.cnf

# Sign the request
openssl x509 -req -days 1024 -in server-req.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out chipper-cert.pem -extfile chp_sign.cnf

