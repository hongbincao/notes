# Open ssl to create self sign certificate
# https://jamielinux.com/docs/openssl-certificate-authority/index.html
# Folder structure
#  ca
#       certs
#       crl
#       newcerts
#       private

#Create folder structure
mkdir /root/ca
cd /root/ca
mkdir certs crl newcerts private

# update permission to 700 for private folder
chmod 700 private

#Create the directory structure. The index.txt and serial files act as a flat file database to keep track of signed certificates.
touch index.txt
echo 1000 > serial

# genereate rsa private key, key length 4096, use aes256 to encrypt it and put into file private/ca.key.pem
openssl genrsa -aes256 -out private/ca.key.pem 4096

#update the key file readonly for the owner
chmod 400 private/ca.key.pem

#Create the root certificate
# req config file, key file, create new , experiation, extensions and output file

openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem


#update readonly for all users
chmod 444 certs/ca.cert.pem

# verify the ca certificate
openssl x509 -in certs/ca.cert.pem -noout -text -fingerprint -subject

# create intermediate CA
mkdir intermediate
cd intermediate
mkdir certs crl private newcerts csr
chmod 700 private
touch index.txt
echo 1000 > serial

#Add a crlnumber file to the intermediate CA directory tree. crlnumber is used to keep track of certificate revocation lists.
echo 1000 > /root/ca/intermediate/crlnumber

# generate the intermediate private key
openssl genrsa -aes256 -out intermediate/private/intermediate.cert.pem 4096

#Create the intermediate certificate requeset
cd /root/ca
openssl req -config intermediate/openssl.cnf -new -sha256 \
      -key intermediate/private/intermediate.key.pem \
      -out intermediate/csr/intermediate.csr.pem

# create the intermediate certificate
openssl ca -config openssl.cnf -in intermediate/csr/intermediate.csr.pem -out intermediate/certs/intermediate.cert.pem \
 -extension v3_intermediate_ca -days 730 -notext -md sha256

#Verify cert file
openssl verify -cafile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem


#Create the certificate chain file
cat intermediate/certs/intermediate.cert.pem \
      certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem

chmod 444 intermediate/certs/ca-chain.cert.pem