packages:
{% if grains.os_family == 'Debian' %}
  pips:
    wanted:
      - docker
    unwanted:
       - docker-py
{% endif %}
  pkgs:
   {# The same package name should appear once, for sanity #}
    unwanted:
        {# docker-formula #}
      - lxc-docker*
      - docker.io*
     {% if grains.os == 'Ubuntu' %}
      - unattended-upgrades
    held:
        {%- if grains.osmajorrelease|int >= 20 %}
      - xserver-xorg-core: '2:1.20*'
        {%- elif grains.osmajorrelease|int >= 18 %}
      - xserver-xorg-core: '2:1.19*'
        {%- else %}
      - xserver-xorg-core: '2:1.18*'
        {%- endif %}
     {% endif %}
    wanted:
      - wget
      - curl
     {% if grains.os_family != 'MacOS' %}
        {# docker-formula #}
      - iptables
      - ca-certificates
     {% endif %}
   {% if grains.os_family == 'Debian' %}
         {# standard #}
      - lsb-core
      - vim
      - virt-what
      - ssh
      - update-motd
      - software-properties-common
         {# docker-formula #}
      - python-pip
      - apt-transport-https
      - python-apt
         {# citrix-linuxvda formula #}
     {% if grains.os == 'Ubuntu' %}
        {%- if grains.osmajorrelease|int >= 20 %}
      - libreadline8
        {%- elif grains.osmajorrelease|int >= 18 %}
      - libreadline7
        {%- endif %}
      - ubuntu-desktop
     {% endif %}
  {% elif grains.os_family == 'RedHat' %}
      - redhat-lsb-core
      - vim-minimal
        {# postgres.dev #}
      - perl-Time-HiRes
      - libicu-devel
      - perl-IPC-Run
      - perl-Test-Simple
        {# Samba #}
      # sssd-libwbclient   #this may break wb
     {% if grains.os == 'Fedora' %}
      - lxde-common
      - python2-dnf-plugin-versionlock
      - python3-dnf-plugin-versionlock
     {% else %}
      - yum-plugin-versionlock
     {% endif %}
          {# docker-formula #}
      - python2-pip
  {% elif grains.os_family == 'Suse' %}
      - lsb-release
      - vim
         {# citrix-linuxvda formula #}
      - xorg-x11
      - xorg-x11-server
      - lxde-common
         {# docker-formula #}
      - python-pip
  {% elif grains.os_family == 'Arch' %}
      - lsb-release
      - vim
      - lxde-task
        {# custom #}
      - alien
      - subversion
      - psmisc
          {# docker-formula #}
      - python2-pip
  {% endif %}
  #    if grains.os != 'MacOS' 
  #snaps:
  #  wanted:
  #    - hello-world
  #  unwanted:
  #    - goodbye-world
  #    endif 
