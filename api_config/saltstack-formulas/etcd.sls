etcd:
  version: 3.4.7
  linux:
    altpriority: {{ range(1, 100000) | random }}
