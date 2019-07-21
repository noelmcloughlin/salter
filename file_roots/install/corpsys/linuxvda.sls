#The following salt states comprise the Corporate Systems XenDesktop (Linux VDA) profile.
#format: YAML

base:
  '*':
    - samba.winbind-ad
    - linuxvda
    - linuxvda.xdping
