

#GOPATH=~/cfssl
#echo $GOPATH
#mkdir -p $GOPATH
#pushd $GOPATH
#go get -u github.com/cloudflare/cfssl/cmd/cfssl
#go get -u github.com/cloudflare/cfssl/cmd/cfssljson

curl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -o /usr/local/bin/cfssl
curl https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -o /usr/local/bin/cfssljson
chmod +x /usr/local/bin/cfssl /usr/local/bin/cfssljson