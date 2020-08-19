
{%- if 'osfingermap' in grains and grains.osfingermap == 'Ubuntu-18.04' %}
mysql:
  serverpkg: mariadb-server-10.1
  clientpkg: mariadb-client-10.1
{%- endif %}
