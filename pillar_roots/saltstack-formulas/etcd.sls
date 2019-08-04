etcd:
  lookup:
    version: 3.2.18
  linux:
    altpriority: {{ range(1, 90000) | random }}
