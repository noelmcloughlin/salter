  {% if grains.os == 'Arch' %}
users:     ##iscsi-formula needs this user
  iscsimake:
    sudouser: True
    shell: /bin/bash
    empty_password: True
    home: /home/iscsimake
    createhome: True
    optional_groups:
      - wheel
      - root
    sudo_rules:
     - 'ALL=(ALL) ALL'
  {% endif %}
