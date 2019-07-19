default_user: undefined_user

users:
  undefined_user:
    sudouser: True
    shell: /bin/bash
    optional_groups:
      - adm
      - wheel
      - docker
    #needs sudo privledges
    sudo_rules:
      - 'ALL=(ALL) ALL'
