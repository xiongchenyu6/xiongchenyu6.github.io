---
author: XiongChenYu
date: "\\[2022-12-07 Wed 21:34\\]"
title: solidity
---

# solidity caveats

## Function type

| Type       | Description                   | Alter State |
|------------|-------------------------------|-------------|
| pure       | Doesn't read or write data    | \[ \]       |
| view       | Reads, but doesn't write data | \[ \]       |
| nonpayable | Default, Probably writes data | \[X\]       |
| payable    | Expecting payment of ether    | \[X\]       |

## Calling smart contracts functions

| Method | Create Transaction | Alter State |
|--------|--------------------|-------------|
| call() | \[ \]              | \[ \]       |
| send() | \[X\]              | \[X\]       |
