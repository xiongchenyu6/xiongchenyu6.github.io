+++
title = "aws"
date = 2023-02-10T17:05:00+08:00
draft = false
+++

## config {#config}

> [default]
> aws_access_key_id = xxx
> aws_secret_access_key = xxx
>
> [mfa]
> source_profile = default
> role_arn = arn:aws:iam::xxxxx
> mfa_serial = arn:aws:iam::xxxx


## gen token with timeout {#gen-token-with-timeout}

aws sts get-session-token --duration-seconds 8888
