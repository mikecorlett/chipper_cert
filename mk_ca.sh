# Generate CA Cert, keys 
openssl req -x509 -newkey rsa:4096 -nodes -days 1024 -keyout ca-key.pem -out ca-cert.pem -subj "/C=GB/ST=England/L=Milton Keynes/O=cbweb"

