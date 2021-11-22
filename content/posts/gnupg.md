+++
title = "GNUPG"
date = 2021-11-20T16:12:00+08:00
draft = false
+++

## Setup permission {#setup-permission}

```sh
find ~/.gnupg -type f -exec chmod 600 {} \; # Set 600 for files
find ~/.gnupg -type d -exec chmod 700 {} \; # Set 700 for directories
```


## GNUPG {#gnupg}


### Encryption {#encryption}

Use recipient public key to encrypt message so only recipient can decrypt and view it
![](/home/freeman.xiong/Private/xiongchenyu6.github.io/content-org/Notes/_20211121_110136screenshot.png)


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


### Sign {#sign}

Use sender private key to encrypt message so everyone can verify the sender identity
![](/home/freeman.xiong/Private/xiongchenyu6.github.io/content-org/Notes/_20211121_110201screenshot.png)

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


### Signature alongside encrypt {#signature-alongside-encrypt}

```sh
gpg -s sample.txt # sign sample.txt.sig
gpg --verify a.sh.gpg
gpg --decrypt a.sh.gpg
```


### Transfer key {#transfer-key}


#### export {#export}

```shell
gpg --export --armor your@id.here > your@id.here.pub.asc
gpg --export-secret-keys --armor your@id.here > your@id.here.priv.asc
gpg --export-secret-subkeys --armor your@id.here > your@id.here.sub_priv.asc
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
