
  {% if grains.os not in ('Windows', 'MacOS',) %}

resolver:
  ng:
    resolvconf:
      enabled: False
  domain: example.com
  nameservers:
    - 8.8.8.8
    - 1.1.1.1
  searchpaths:
    - example.com
  options:
    - rotate
    - timeout:1
    - attempts:5

  {%- endif %}
