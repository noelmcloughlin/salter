  {% if grains.os not in ('Windows', 'MacOS',) %}

linuxvda:
  fqdn_resolver_alias: 'salt'
  enable_ntp_timesync: timedatectl set-ntp True
  domain: example.com
    ##Default to version 7.16 (dec2017) as version 1811 is not working on Ubuntu 18.04
    {%- if grains.os_family == 'RedHat' %}

  src_pkg: 'XenDesktopVDA-7.16.0.412-1.el7_x.x86_64.rpm'
  src_hash: 'sha256=8b75157869fda9db2a8bebeffee75619fcda4d9dcadac62f013d4f89a7a6ffe6'
  #src_pkg: LinuxVDA-1811.el7_x.rpm
  #src_hash: sha256=80a995c2c4a042fd57092b8a5bc69f3d50c0ec8a468d1edc817789eff480dfac

    {%- elif grains.os_family == 'Suse' %}

  src_pkg: 'XenDesktopVDA-7.16.0.412-1.sle12_x.x86_64.rpm'
  src_hash: 'sha256=57bd03ee4a01cce9a01571eba668b0dcc34787a9f7a4b8a637696172860206f7'
  #src_pkg: LinuxVDA-1811.sle12_x.rpm
  #src_hash: sha256=4120d9f4a8589a49fa34ac75c65c2e8ea639f464aea54bf553ea22c9eb27d0ef

    {%- elif grains.os == 'Ubuntu' %}

  src_pkg: 'xendesktopvda_7.16.0.412-1.ubuntu16.04_amd64.deb'
  src_hash: 'fc48ad39be54cae0034e9302908aa146'
  #src_pkg: LinuxVDA-1811.ubuntu16.04.deb
  #src_hash: sha256=cdc999d964fab391cd4680607d464d2619b7cd620995392edb3852c5db5ce715
    {%- endif %}

  citrix:
    uri: http://example.com/downloads/corpsys/xendesktop/
    variables:
      #CTX_XDL_VDA_PORT: 8585
      CTX_XDL_HDX_3D_PRO: N
      {% if grains.os_family == 'Debian' %}
      CTX_XDL_DDC_LIST: ctxdev01.example.com
      {% else %}
      CTX_XDL_DDC_LIST: dc01.example.com dc02.example.com
      {% endif %}
      # Set Y for dedicated desktop delivery model (VDI), N for 'server/shared' model.
      CTX_XDL_VDI_MODE: Y
      {%- if grains.os == 'Ubuntu' and grains.osmajorrelease|int < 18 %}
  xdping:
    archive: linux-xdping.tar
    hash: sha256=38cf8ff42cd0d610ba7323689046cd1492db912c9f722932e99c13869301186a
      {% endif %}

  {% endif %}
