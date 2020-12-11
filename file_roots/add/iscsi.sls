base:
  '*':
      {% if grains.os_family == 'Arch' %}
    - users   #we need iscsimake user on archlinux
      {%- endif %}
    - iscsi
