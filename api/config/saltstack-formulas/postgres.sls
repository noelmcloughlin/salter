# -*- coding: utf-8 -*-
# vim: ft=yaml
---
postgres:
  version: 13
  postgresconf: |-
    listen_addresses = '*'  # or localhost,192.168.1.1'
  users:
    airflow:
      ensure: present
      password: airflow
      createdb: true
      inherit: true
      createroles: true
      replication: true
  databases:
    airflow:
      owner: airflow
  acls:
      # scope, db, user, [ cidr ] ..
    - ['local', 'airflow', 'airflow', 'md5']
    - ['local', 'all', 'all', 'peer']
    - ['host', 'all', 'all', '127.0.0.1/32', 'md5']
    - ['host', 'all', 'all', '191.168.1.1/32', 'md5']
    - ['host', 'all', 'all', '191.168.1.2/32', 'md5']
    - ['host', 'all', 'all', '::1/128', 'md5']
    - ['local', 'replication', 'all', 'peer']
    - ['host', 'replication', 'all', '127.0.0.1/32', 'md5']
    - ['host', 'replication', 'all', '::1/128', 'md5']
            {# for citrix-linuxvda formula #}
    - ['local', 'all', 'postgres', '', 'ident',]
    - ['local', 'citrix-confdb', 'root', '', 'ident',]
    - ['local', 'citrix-confdb', 'ctxsrvr', '', 'ident',]
    - ['local', 'citrix-confdb', 'guest', '', 'trust',]
    - ['host', 'citrix-confdb', 'ctxvda', '127.0.0.1/32', 'password',]
    - ['host', 'citrix-confdb', 'guest', '127.0.0.1/32', 'trust',]
    - ['host', 'citrix-confdb', 'ctxvda', '::1/128', 'password',]
    - ['host', 'citrix-confdb', 'guest', '::1/128', 'trust',]
...
