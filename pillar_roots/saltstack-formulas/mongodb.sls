mongodb:
  wanted:
    database:
      - mongod
    gui:
      - robo3t
         {%- if grains.kernel|lower == 'darwin' %}
      - compass    # mongodb compass upstream rpm/deb packages has gui dependencies
         {%- endif %}
    connectors: []

  pkg:
    database:
      mongod:
        version: 4.2.6.1
        config:
          replication: {}
          sharding: {}
    gui:
      compass:
        version: 1.21.2
      robo3t:
        version: 1.3.1
    connectors:
      bi:
        version: 2.13.4
      kafka:
        version: 1.1.0
      spark:
        name: mongo-spark
        version: 2.4.1

  linux:
    altpriority: 10000
