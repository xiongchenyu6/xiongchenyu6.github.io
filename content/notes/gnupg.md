+++
title = "GNUPG"
date = 2021-11-20T16:12:00+08:00
draft = false
+++

## Setup new key {#setup-new-key}

```sh
export KEY_NAME="office.trontech.link"
export KEY_COMMENT="flux secrets"

gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${KEY_NAME}
EOF

gpg --list-secret-keys "${KEY_NAME}"

export KEY_FP="A27D 0937 F9E0 95BB 9B24  7B49 778B 8150 7612 BF48"


gpg --export-secret-keys --armor "${KEY_FP}" |
kubectl create secret generic sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin

gpg --delete-secret-keys "${KEY_FP}"
```


## Setup permission {#setup-permission}

```sh
find ~/.gnupg -type f -exec chmod 600 {} \; # Set 600 for files
find ~/.gnupg -type d -exec chmod 700 {} \; # Set 700 for directories
```


## GNUPG {#gnupg}


### Encryption <span class="tag"><span class="ATTACH">ATTACH</span></span> {#encryption}

Use recipient public key to encrypt message so only recipient can decrypt and view it
![](/ox-hugo/clipboard-20250617T142342.png)


#### decrypt <span class="tag"><span class="ATTACH">ATTACH</span></span> {#decrypt}

```shell
gpg --decrypt a.sh.gpg
gpg -q --pinentry-mode loopback --for-your-eyes-only --no-tty -d ~/.password/gmail.gpg
```


#### encrypt {#encrypt}

```shell
gpg --encrypt -r person@email.com name_of_file
gpg --encrypt name_of_file
```


### Sign <span class="tag"><span class="ATTACH">ATTACH</span></span> {#sign}

Use sender private key to encrypt message so everyone can verify the sender identity
![](/ox-hugo/clipboard-20250617T142323.png)

```sh
gpg -b sample.txt
gpg --verify sample.txt.sig sample.txt
gpg --verify sample.txt.sig # save folder
```

since \*.sig file is not readable more commonly use clear text signature shown as below

```sh
gpg --clear-sign sample.txt
gpg --verify sample.txt.asc
```


#### Sign string {#sign-string}

```sh
echo "ee7d52053138e716702261914a330059ed470b1106b75569b18326e9c1e04d27" | gpg -a --default-key 5AF7AFBF695E8A5D --detach-sig
```


### Signature alongside encrypt <span class="tag"><span class="ATTACH">ATTACH</span></span> {#signature-alongside-encrypt}

{{< figure src="/ox-hugo/clipboard-20250617T142237.png" >}}

```sh
gpg -s sample.txt # sign sample.txt.sig
gpg --verify a.sh.gpg
gpg --decrypt a.sh.gpg
```


### Transfer key {#transfer-key}


#### exportq {#exportq}

```shell
gpg --export --armor > public.key
gpg --export-secret-keys > private.key
gpg --export-secret-subkeys --armor > sub_private.key
gpg --export-ownertrust > ownertrust.txt
```


#### delete {#delete}

```sh
gpg –delete-secret-keys
gpg –delete-key
```


#### import {#import}

```sh
gpg --import your@id.here.pub.asc
gpg --import your@id.here.priv.asc
gpg --import your@id.here.sub_priv.asc
gpg --import-ownertrust ownertrust.txt
```


#### trust imported key {#trust-imported-key}

```sh
gpg --edit-key your@id.here
gpg> trust
Your decision? 5 (Ultimate trust)
```


#### change expire date {#change-expire-date}

change primary key then secondary

```sh
gpg --list-keys
gpg --edit-key xiongchenyu
g> expire
g> key 1
g> expire

```
