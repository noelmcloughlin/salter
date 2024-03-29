# -*- coding: utf-8 -*-
# vim: ft=yaml
---
rabbitmq:
  erlang_cookie: shared-secret
  nodes:
    rabbit:  # default node name
      config:
        auth_backends.1: internal   # default
        listeners.tcp.1: 0.0.0.0:5672
        # https://www.rabbitmq.com/consumers.html#acknowledgement-timeout
        consumer_timeout: 3600000
        # https://www.rabbitmq.com/ldap.html
        # auth_backends.2: ldap
        # auth_ldap.servers.1: ldapserver.new
        # auth_ldap.servers.2: ldapserver.old
        # auth_ldap.user_dn_pattern: cn=${username},OU=myOrg,DC=example,DC=com
        # auth_ldap.log: false
        # auth_ldap.dn_lookup_attribute: sAMAccountName  # or userPrincipalName
        # auth_ldap.dn_lookup_base: OU=myOrg,DC=example,DC=com
      plugins:
        - rabbitmq_management
        - rabbitmq_federation
        - rabbitmq_federation_management
        - rabbitmq_auth_backend_ldap
        - rabbitmq_shovel
        - rabbitmq_shovel_management
      vhosts:
        - default_vhost
      queues:
        my-queue:
          user: saltstack_mq
          passwd: password
          durable: 'true'
          auto_delete: 'false'
          vhost: default_vhost
      bindings:
        my-binding:
          source: 'amq.topic'
          destination_type: queue
          destination: my-queue
          routing_key: a_routing_key_string
          user: saltstack_mq
          passwd: 'password'
          vhost: default_vhost
      exchanges:
        my-exchange:
          user: saltstack_mq
          passwd: 'password'
          type: fanout
          durable: 'true'
          internal: 'false'
          auto_delete: 'false'
          vhost: default_vhost
          arguments:
            alternate-**exchange: 'amq.fanout'
            test-header: 'testing'
      remove_guest_user: true
      users:
        user1:
          password: password
          force: true
          tags:
            - monitoring
            - user
          perms:
            default_vhost:
              - '.*'
              - '.*'
              - '.*'
        saltstack_mq:
          password: password
          force: false
          tags:
            - administrator
            - management
          perms:
            default_vhost:
              - '.*'
              - '.*'
              - '.*'
        airflow:
          password: 'airflow'
          force: true
          tags:
            - management
            - administrator
          perms:
            'default_vhost':
              - '.*'
              - '.*'
              - '.*'
      parameters:
        my-federation-upstream-set:
          component: federation-upstream-set
          definition:
            # todo: multiple dict items (not just one)
            upstream: my-federation-upstream1
          vhost: default_vhost
        my-federation-upstream1:
          component: federation-upstream
          definition:
            uri: 'amqp://saltstack_mq:password@localhost'
            ack-mode: on-confirm
            trust-user-id: true
            max-hops: 1
          vhost: default_vhost
      policies:
        my-federation-policy1:
          definition:
            federation-upstream-set: all
          pattern: '^federated1\.'
          priority: 1
          vhost: default_vhost
        my-federation-policy2:
          definition:
            federation-upstream-set: my-federation-upstream-set
          pattern: '^federated2\.'
          priority: 1
          vhost: default_vhost
        my-ha-policy:
          definition:
            ha-mode: nodes
            ha-params: ["rabbit", "rabbit2"]
          pattern: '.*'
          priority: 1
          vhost: default_vhost

    rabbit2:
      nodeport: 5673
      distport: 25673
      clustered: false    # true
      join_node: rabbit   # create multinode cluster on localhost
      config:
        auth_backends.1: internal   # default
        listeners.tcp.1: 0.0.0.0:5673
        # https://www.rabbitmq.com/ldap.html
        # auth_backends.2: ldap
        # auth_ldap.servers.1: ldapserver.new
        # auth_ldap.servers.2: ldapserver.old
        # auth_ldap.user_dn_pattern: cn=${username},OU=myOrg,DC=example,DC=com
        # auth_ldap.log: false
        # auth_ldap.dn_lookup_attribute: sAMAccountName  # or userPrincipalName
        # auth_ldap.dn_lookup_base: OU=myOrg,DC=example,DC=com
      service: true
      plugins: []
      vhosts:
        - rabbit2_vhost
      queues:
        my-queue:
          user: saltstack_mq
          passwd: password
          durable: 'true'
          auto_delete: 'false'
          vhost: rabbit2_vhost
          arguments:
            x-dead-letter-exchange: my-exchange
            x-expires: 8640000
            x-queue-type: quorum
      bindings:
        my-binding:
          source: 'amq.topic'
          destination_type: queue
          destination: my-queue
          routing_key: a_routing_key_string
          user: saltstack_mq
          passwd: 'password'
          vhost: rabbit2_vhost
      exchanges:
        my-exchange:
          user: saltstack_mq
          passwd: 'password'
          type: fanout
          durable: 'true'
          internal: 'false'
          auto_delete: 'false'
          vhost: rabbit2_vhost
          arguments:
            alternate-**exchange: 'amq.fanout'
            test-header: 'testing'
      remove_guest_user: true
      users:
        user1:
          password: password
          force: true
          tags:
            - monitoring
            - user
          perms:
            rabbit2_vhost:
              - '.*'
              - '.*'
              - '.*'
        saltstack_mq:
          password: password
          force: false
          tags:
            - administrator
          perms:
            rabbit2_vhost:
              - '.*'
              - '.*'
              - '.*'
        airflow:
          password: 'airflow'
          force: true
          tags:
            - management
            - administrator
          perms:
            'rabbit2_vhost':
              - '.*'
              - '.*'
              - '.*'
      parameters:
        my-federation-upstream-set:
          component: federation-upstream-set
          definition:
            # todo: multiple dict items (not just one)
            upstream: my-federation-upstream1
          vhost: rabbit2_vhost
        my-federation-upstream1:
          component: federation-upstream
          definition:
            uri: 'amqp://saltstack_mq:password@localhost'
            ack-mode: on-confirm
            trust-user-id: true
            max-hops: 1
          vhost: rabbit2_vhost
      policies:
        my-federation-policy1:
          definition:
            federation-upstream-set: all
          pattern: '^federated1\.'
          priority: 1
          vhost: rabbit2_vhost
        my-federation-policy2:
          definition:
            federation-upstream-set: my-federation-upstream-set
          pattern: '^federated2\.'
          priority: 1
          vhost: rabbit2_vhost
        my-ha-policy:
          definition:
            ha-mode: nodes
            ha-params: ["rabbit", "rabbit2"]
          pattern: '.*'
          priority: 1
          vhost: rabbit2_vhost

  pkg:
    # https://github.com/rabbitmq/rabbitmq-server/releases/tag/v3.8.14
    use_upstream: repo  # if available (i.e. packagecloud)
  environ:
    locale_all: en_US.UTF-8
    values: {}
    # https://www.rabbitmq.com/relocate.html
    # rabbitmq_mnesia_base: /var/lib/rabbitmq/mnesia
    # RABBITMQ_USE_LONGNAME: true  # not working in ci
    # https://www.rabbitmq.com/configure.html#supported-environment-variables
    # RABBITMQ_LOG_BASE: /var/log/rabbitmq
  dir:
    base: /var/lib/rabbitmq

  tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    files_switch:
      - any/path/can/be/used/here
      - id
      - roles
      - osfinger
      - os
      - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://rabbitmq/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   rabbitmq-config-file-file-managed:
    #     - 'example_alt.tmpl'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    source_files:
      rabbitmq-config-file-file-managed:
        - 'example.tmpl.jinja'

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
