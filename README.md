# chipper_cert

**Create CA cert and server cert / key pair for chipper**

There are two certificates; one is the certificate that the server (chipper/escapepod) offers to the client (vic-cloud on Vector). The second is the root/CA cert which vector uses to validate the certificate offered by the server. 

**ca_cert**

`mk_ca.sh` generates the CA cert file `ca_cert.pem`. The attributes of the cert are on the openssl command line

The ca_cert file needs to be installed on Vector for him to connect to the cipper service; It can be installed in vic-cloud directly. I added mine to internal/jdocs/escapepod_root_cert.go and modified internal/jdocs/client.go to append the new cert as well as the DDL supplied escape pod cert, e.g. around line 26:

	func newConn(ctx context.Context, opts *options) (*conn, error) {

	pool := rootcerts.ServerCertPool()

	_ = pool.AppendCertsFromPEM([]byte(escapepodRootPEM_MC))
	_ = pool.AppendCertsFromPEM([]byte(escapepodRootPEM_DDL))

**ca_cert and key**

'mk_chipper.sh' generates `chipper_cert.pem` and `chipper_key.pem` in a two step process - generate the certificate signing request (and private key), and generate the signed certificate. 

The chipper cert and key need to be passed to chipper in environment variables as text, e.g.

	#!/bin/bashcert=$(<certs/chipper-cert.pem)   
	key=$(<certs/chipper-key.pem)   
	export DDL_RPC_PORT=8084   
	export DDL_RPC_TLS_CERTIFICATE=$cert   
	export DDL_RPC_TLS_KEY=$key   
	./chipper/chipper   

There are other test files still in this repo...

