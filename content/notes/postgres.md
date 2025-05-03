+++
title = "postgres"
date = 2021-11-26T22:05:00+08:00
draft = false
+++

## Install {#install}

```dockerfile
USER postgres
RUN psql -U username -d mydatabase -c "ALTER USER postgres WITH PASSWORD 'pass'"
```


## Create new table and new username {#create-new-table-and-new-username}

```sql
create database rustwebserver;
create role rustwebserver with login password 'rustwebserver';
grant all privileges on database rustwebserver to rustwebserver;
CREATE DATABASE rustwebserver WITH OWNER rustwebserver TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
Delete database rustWebServerdb;
```


## Export and import {#export-and-import}

export

```sql
\copy (select * from xx) TO "xx.csv"
```

import

```nil
COPY sample_table_name
FROM 'C:\sampledb\sample_data.csv'
DELIMITER ','
CSV HEADER;
```


## get config path {#get-config-path}

```dockerfile
psql -U postgres -c 'SHOW config_file'
```


## show all DB size {#show-all-db-size}

```sql
select pg_database.datname, pg_size_pretty(pg_database_size(pg_database.datname)) AS size from pg_database;
select relname, pg_size_pretty(pg_relation_size(relid)) from pg_stat_user_tables order by pg_relation_size(relid) desc;
```


## Logical replication {#logical-replication}


### create logical replication {#create-logical-replication}

```sql
SELECT * FROM pg_create_logical_replication_slot('slot_repls', 'wal2json');
```


### list all logical replications {#list-all-logical-replications}

```sql
SELECT * FROM pg_replication_slots;
```


### drop {#drop}

```sql
select pg_drop_replication_slot('bottledwater');
```


### view {#view}

```sql
SELECT * FROM pg_logical_slot_get_changes('slot_repls', NULL, NULL);
SELECT * FROM pg_logical_slot_peek_changes('slot_repls', NULL, NULL);
```


## insert {#insert}

```sql
INSERT INTO table_name(statis_date, type, spoa_id, offer_id, service_name, result, cnt, amt, currency) VALUES (20111128, 'os_steam', '1', '1', '1', 'SUCCESS',1, 12, 'USD');
```

```sh
psql -v ON_ERROR_STOP=1 --username chenyu --dbname teg_sett <<- EOSQL
    SELECT * FROM t_billing_center_check_statis_external LIMIT 1;
EOSQL
```


## alter {#alter}

```sql
ALTER TABLE tbl_name ALTER COLUMN col_name TYPE varchar (11);
ALTER TABLE table_name ADD COLUMN new_column_name data_type constraint;
```
