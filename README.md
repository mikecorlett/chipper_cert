# chipper_cert

**Create CA cert and server cert / key pair for chipper**

The ca_cert file needs to be installed on Vector for him to connect to the cipper service; It can be installed in vic-cloud directly. I added mine to internal/jdocs/escapepod_root_cert.go and modified internal/jdocs/client.go to append the new cert as well as the DDL supplied escape pod cert, e.g. around line 26:

`func newConn(ctx context.Context, opts *options) (*conn, error) {

	pool := rootcerts.ServerCertPool()

	_ = pool.AppendCertsFromPEM([]byte(escapepodRootPEM_MC))
	_ = pool.AppendCertsFromPEM([]byte(escapepodRootPEM_DDL))
`

The chipper cert and key need to be passed to chipper, e.g.

`#!/bin/bash  
cert=$(<certs/chipper-cert.pem)  
key=$(<certs/chipper-key.pem)  
export DDL_RPC_PORT=8084  
export DDL_RPC_TLS_CERTIFICATE=$cert  
export DDL_RPC_TLS_KEY=$key  
./chipper/chipper  
`
