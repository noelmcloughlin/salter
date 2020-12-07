# -*- coding: utf-8 -*-
# vim: ft=yaml
---
postgres:
  # Ref: https://github.com/saltstack-formulas/postgres-formula/blob/master/pillar.example

  linux:
    altpriority: {{ range(1, 9100000) | random }}

  postgresconf: |
    listen_addresses = '*'  # listen on all interfaces
  acls:
    - ['local', 'db1', 'localUser']
    - ['host', 'db2', 'remoteUser', '192.168.33.0/24']
  {# for citrix-linuxvda formula #}
    - ['local', 'all', 'postgres', '', 'ident',]
    - ['local', 'citrix-confdb', 'root', '', 'ident',]
    - ['local', 'citrix-confdb', 'ctxsrvr', '', 'ident',]
    - ['local', 'citrix-confdb', 'guest', '', 'trust',]
    - ['host', 'citrix-confdb', 'ctxvda', '127.0.0.1/32', 'password',]
    - ['host', 'citrix-confdb', 'guest', '127.0.0.1/32', 'trust',]
    - ['host', 'citrix-confdb', 'ctxvda', '::1/128', 'password',]
    - ['host', 'citrix-confdb', 'guest', '::1/128', 'trust',]
  {# for airflow formula #}
    - ['local', 'airflow', 'airflow', 'md5']
    - ['local', 'all', 'all', 'peer']
    - ['host', 'all', 'all', '127.0.0.1/32', 'md5']
    - ['host', 'all', 'all', '::1/128', 'md5']
    - ['local', 'replication', 'all', 'peer']
    - ['host', 'replication', 'all', '127.0.0.1/32', 'md5']
    - ['host', 'replication', 'all', '::1/128', 'md5']

  users:
    airflow:
      ensure: present
      password: airflow
      createdb: true
      inherit: true
      createroles: true
      replication: true

  # databases to be created
  databases:
    airflow:
      owner: airflow
