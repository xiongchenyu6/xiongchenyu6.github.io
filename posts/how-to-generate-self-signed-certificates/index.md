# 自生成key以及签名


dsfasafafdsfdsaffdsafdafdsffdfdfadsfsfdfasf
dafdsfdsfdsafsdfdfasdfdfsdf

```sh
openssl req -new -x509 -subj "/C=SG/CN=fingerone.com" \
                  -addext "subjectAltName = DNS:fingerone.com" \
                  -addext "certificatePolicies = 1.2.3.4" \
                  --keyout localhost.pem -out localhost.pem -days 365 -nodes
```

```sh
openssl req -new -x509 -subj "/C=SG/CN=fingertwo.com" \
                  -addext "subjectAltName = DNS:fingertwo.com" \
                  -addext "certificatePolicies = 1.2.3.4" \
                  --keyout localhost2.pem -out localhost2.pem -days 365 -nodes
```

```sh
openssl req -new -x509 -subj "/C=SG/CN=riskcontrol.com" \
                  -addext "subjectAltName = DNS:riskcontrol.com" \
                  -addext "certificatePolicies = 1.2.3.4" \
                  --keyout riskcontrol.pem -out riskcontrol.pem -days 365 -nodes
```

```sh
openssl pkcs12 -export -out identity.pfx -inkey riskcontrol.pem -in riskcontrol.pem -certfile riskcontrol.pem
```

