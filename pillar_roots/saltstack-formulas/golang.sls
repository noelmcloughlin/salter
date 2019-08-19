golang:
  pkg:
    archive:
      uri: https://storage.googleapis.com/golang

    {%- if grains.kernel|lower == 'linux' %}
  linux:
    # 'Alternatives system' priority: zero disables (default)
    altpriority: {{ range(1, 9100000) | random }}
    {%- endif %}

  cmd:
    goget:
      - github.com/golang/example/hello
      - github.com/golang/example/outyet
    clean:
      - github.com/golang/example/hello
      - github.com/golang/example/outyet
