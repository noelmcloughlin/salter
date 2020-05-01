eclipse:
  edition: java       # javascript, jee, modeling, etc
  release: 2020-03
  version: R
  identity:
    user: undefined_user
  linux:
    altpriority: {{ range(1, 9100000) | random }}
