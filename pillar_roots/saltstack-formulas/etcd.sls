etcd:
  version: 3.4.7
  linux:
    altpriority: {{ range(1, 90000) | random }}
