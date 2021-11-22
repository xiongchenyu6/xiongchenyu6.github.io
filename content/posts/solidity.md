+++
title = "solidity"
date = 2022-12-07T21:34:00+08:00
draft = false
author = "Xiong ChenYu"
+++

## solidity caveats {#solidity-caveats}


### Function type {#function-type}

| Type       | Description                   | Alter State |
|------------|-------------------------------|-------------|
| pure       | Doesn't read or write data    | [ ]         |
| view       | Reads, but doesn't write data | [ ]         |
| nonpayable | Default, Probably writes data | [X]         |
| payable    | Expecting payment of ether    | [X]         |


### Calling smart contracts functions {#calling-smart-contracts-functions}

| Method | Create Transaction | Alter State |
|--------|--------------------|-------------|
| call() | [ ]                | [ ]         |
| send() | [X]                | [X]         |
