#The following salt states comprise the Corporate Systems XenDesktop (Linux VDA) profile.
#format: YAML

base:
  '*':
    - timezone
        {%- if grains.os_family in ('RedHat',) %}
    - epel
        {%- endif %}
    - packages
    # example.groups
    - users
    - postgres
    - firewalld
    - resolver.ng
    - chrony
    - chrony.config
    - kerberos
    - samba
    - samba.client
    - samba.config
    - samba.winbind
