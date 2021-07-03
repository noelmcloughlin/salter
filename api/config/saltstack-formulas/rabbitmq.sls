# -*- coding: utf-8 -*-
# vim: ft=yaml
---
rabbitmq:
  cluster:
    rabbit@locahost:
      user: rabbit       # user is confusing keyname; should be 'node: rabbit'
      host: 127.0.0.1    # host of (primary rabbitmq cluster) node to join to
      ram_node: None
      runas: rabbitmq
      erlang_cookie:
        name: /var/lib/rabbitmq/.erlang.cookie
        value: shared-value-for-all-cluster-members
  vhost:
    - airflow
  user:
    airflow:
      - password: 'airflow'
      - force: true
      - tags:
        - management
        - administrator
      - perms:
          - 'airflow':
            - '.*'
            - '.*'
            - '.*'
      - runas: rabbitmq
  queue:
    airflow:
      # note dict format
      user: airflow
      passwd: airflow
      durable: true
      auto_delete: false
      vhost: airflow
      arguments:
        - 'x-message-ttl': 8640000
        - 'x-expires': 8640000
        - 'x-dead-letter-exchange': 'airflow'
  binding:
    airflow:
      - destination_type: queue
      - destination: airflow
      - routing_key: airflow_routing_key
      - user: airflow
      - passwd: password
      - vhost: airflow
      - arguments:
          - 'x-message-ttl': 8640000
  exchange:
    airflow:
      - user: airflow
      - passwd: airflow
      - type: fanout
      - durable: true
      - internal: false
      - auto_delete: false
      - vhost: airflow
      - arguments:
          - 'alternate-**exchange': 'amq.fanout'
          - 'test-header': 'testing'
  policy: {}
  upstream: {}
...
