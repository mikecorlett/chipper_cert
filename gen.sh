#rm *.pem
#rm *.srl
# Generate CA Cert, keys 
openssl req -x509 -newkey rsa:4096 -nodes -days 1024 -keyout ca-key.pem -out ca-cert.pem -subj "/C=GB/ST=England/L=Milton Keynes/O=cbweb"

# Generate server key and CSR
openssl req -newkey rsa:4096 -nodes -keyout chipper-key.pem -out server-req.pem -config srv_san.cnf

# Sign the request
openssl x509 -req -days 1024 -in server-req.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out chipper-cert.pem -extfile sign.cnf

