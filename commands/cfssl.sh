
# Installation: 
curl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -o /usr/local/bin/cfssl
curl https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -o /usr/local/bin/cfssljson
chmod +x /usr/local/bin/cfssl /usr/local/bin/cfssljson

CSR -> Certificate Signing Request


#CSR JSON format

{
    "CN": "My own CA",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "US",
            "L": "CA",
            "O": "My Company Name",
            "ST": "San Francisco",
            "OU": "Org Unit 1",
            "OU": "Org Unit 2",
            "anykey": "any value",
            "emailAddress": "contoso@live.com"
        }
    ]
}

# Generate root CA
# cfssl gencert will generate the certificate, certificate request and certificate private key
cfssl gencert -initca ca-csr.json | cfssljson -bare admin –

# CA config format
# ca-config.json
{
    "signing": {
        "default": {
            "expiry": "43800h"
        },
        "profiles": {
            "server": {
                "expiry": "43800h",
                "usages": [
                    "signing",
                    "key encipherment",
                    "server auth"
                ]
            },
            "client": {
                "expiry": "43800h",
                "usages": [
                    "signing",
                    "key encipherment",
                    "client auth"
                ]
            },
            "peer": {
                "expiry": "43800h",
                "usages": [
                    "signing",
                    "key encipherment",
                    "server auth",
                    "client auth"
                ]
            }
        }
    }
}

# New certificate
#apicert-csr.json 
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 4096
  },
  "hosts":[
      "192.168.0.1",
      "contoso.com",
      "*.contoso.com"
  ],
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}

# Generate kubernetes certificate from CA
cfssl gencert -ca admin.pem -ca-key admin-key.pem -config ca-config.json -profile server apicert-csr.json | cfssljson -bare apiserver