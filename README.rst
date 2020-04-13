=======
Salter:
=======
A software meta profile manager for MacOS, FreeBSD, and Linux.

.. contents:: **Table of Contents**

Installation
============

Paste this in a Terminal::

    curl -o salter.sh https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh && sudo bash salter.sh add bootstrap && sudo bash salter.sh add salter

User
====
The '-u username' option is never required on MacOS. On Linux, its required for "Developer-type" software (IDEs, etc). 
When in doubt pass the '-u username' argument, when it makes sense.

Usage Examples
==============

Add profiles::

    sudo salter add intelli -u vagrant
    sudo salter add apache

Remove profile::

    sudo salter add kubernetes -u vagrant
    sudo salter remove kubernetes

Create profile::

    sudo salter edit mystuff
    # This is a profile template which you must customize
    # The format is a YAML list; indention is important
    # See https://github.com/saltstack-formulas for valid entries
    base:
      '*':
        - item1    #<-- changeme
        - item2    #<-- changeme
        - .etc.    #<-- changeme

Show profile::

    sudo salter show mystuff

    base:
      *:
        - nginx
        - intellij
        - kubernetes
        - chrome

Test new profile::

    $ sudo salter add mystuff
    $ sudo salter remove mystuff


Namespaces
==========
Pre-written salt states are maintained by open source communities upstream:

* `saltstack-formulas`_ (default) I only test this NAMESPACE!!!
* `salt-formulas`_ (future maybe)
* `eligundry`_ (why not)
* many more

Saltstack Formulas Namespace
============================

::

    sudo salter add accumulo
    sudo salter add aegir
    sudo salter add apache
    sudo salter add androidstudio
    sudo salter add appcode -u vagrant
    sudo salter add apt
    sudo salter add aptly
    sudo salter add avahi
    sudo salter add aws -u vagrant
    sudo salter add backupninja
    sudo salter add backuptocloud
    sudo salter add bareos
    sudo salter add barman
    sudo salter add beats -u vagrant
    sudo salter add beaver
    sudo salter add bigtest
    sudo salter add bind
    sudo salter add bro
    sudo salter add cassandra -u vagrant
    sudo salter add ceph
    sudo salter add cerebro
    sudo salter add cert
    sudo salter add charles
    sudo salter add chef
    sudo salter add chrony
    sudo salter add chrome
    sudo salter add chromium
    sudo salter add circus
    sudo salter add ckan
    sudo salter add clamav
    sudo salter add clion
    sudo salter add cloudfoundry -u vagrant
    sudo salter add cobbler
    sudo salter add cockroachdb
    sudo salter add collectd
    sudo salter add consul
    sudo salter add couchdb
    sudo salter add cron
    sudo salter add crontab
    sudo salter add datagrip -u vagrant
    sudo salter add dbeaver
    sudo salter add ddclient
    sudo salter add deepsea
    sudo salter add deepsea_post
    sudo salter add dehydrated
    sudo salter add dev
    sudo salter add devstack -u vagrant
    sudo salter add dhcpd
    sudo salter add dirvish
    sudo salter add django
    sudo salter add dnsmasq
    sudo salter add docker-compose
    sudo salter add docker-containers
    sudo salter add docker -u vagrant
    sudo salter add dovecot
    sudo salter add eclipse -u vagrant
    sudo salter add elasticsearch
    sudo salter add emacs -u vagrant
    sudo salter add emby
    sudo salter add epazote
    sudo salter add epel
    sudo salter add etcd
    sudo salter add exim
    sudo salter add fail2ban
    sudo salter add filebeat
    sudo salter add firewalld
    sudo salter add fluentbit
    sudo salter add flume
    sudo salter add frr
    sudo salter add gasmask
    sudo salter add gce
    sudo salter add gerrit
    sudo salter add git
    sudo salter add gitlab
    sudo salter add gitolite
    sudo salter add goland -u vagrant
    sudo salter add golang -u vagrant
    sudo salter add grafana
    sudo salter add graphite
    sudo salter add graylog
    sudo salter add hadoop
    sudo salter add haproxy
    sudo salter add helm
    sudo salter add hostapd
    sudo salter add hostsfile
    sudo salter add hugo
    sudo salter add icinga2
    sudo salter add immortal
    sudo salter add insomnia
    sudo salter add influxdb
    sudo salter add intellij -u vagrant
    sudo salter add iptables
    sudo salter add iscsi
    sudo salter add ius
    sudo salter add java
    sudo salter add jenkins
    sudo salter add joomla
    sudo salter add kafka
    sudo salter add keepalived
    sudo salter add kibana
    sudo salter add kubernetes -u vagrant
    sudo salter add latex
    sudo salter add letsencrypt
    sudo salter add librenms
    sudo salter add libvirt
    sudo salter add lighttpd
    sudo salter add lldpd
    sudo salter add locale
    sudo salter add logrotate
    sudo salter add logstash
    sudo salter add lvm
    sudo salter add lxc
    sudo salter add lxd
    sudo salter add lynis
    sudo salter add macbook
    sudo salter add mailhog
    sudo salter add maven -u vagrant
    sudo salter add memcached
    sudo salter add mercurial
    sudo salter add metricbeat
    sudo salter add mirth
    sudo salter add molten
    sudo salter add mongodb -u vagrant
    sudo salter add monit
    sudo salter add moosefs
    sudo salter add msdtc
    sudo salter add munin
    sudo salter add mysql
    sudo salter add nagios
    sudo salter add newrelic
    sudo salter add nexus
    sudo salter add nfs
    sudo salter add nginx
    sudo salter add node
    sudo salter add nomad
    sudo salter add ntp
    sudo salter add nut
    sudo salter add nvm
    sudo salter add opendkim
    sudo salter add openldap
    sudo salter add openntpd
    sudo salter add opensds
    sudo salter add openssh
    sudo salter add openvas
    sudo salter add openvpn
    sudo salter add os-hardening
    sudo salter add owncloud
    sudo salter add oxidized
    sudo salter add packages
    sudo salter add packer
    sudo salter add pam
    sudo salter add patchwork
    sudo salter add perl
    sudo salter add pfring
    sudo salter add php
    sudo salter add phpstorm -u vagrant
    sudo salter add pimpmylog
    sudo salter add pip
    sudo salter add piwik
    sudo salter add plex
    sudo salter add postfix
    sudo salter add postman
    sudo salter add postgres
    sudo salter add powerdns
    sudo salter add pppoe
    sudo salter add proftpd
    sudo salter add prometheus
    sudo salter add pulp
    sudo salter add pycharm -u vagrant
    sudo salter add rabbitmq
    sudo salter add rectangle
    sudo salter add redis
    sudo salter add redmine
    sudo salter add remi
    sudo salter add resolver
    sudo salter add rider -u vagrant
    sudo salter add rinetd
    sudo salter add rkhunter
    sudo salter add rlang
    sudo salter add rspamd
    sudo salter add rstudio
    sudo salter add rsyncd
    sudo salter add rsyslog
    sudo salter add ruby
    sudo salter add rubymine
    sudo salter add rundeck
    sudo salter add runit
    sudo salter add salt
    sudo salter add samba
    sudo salter add schroot
    sudo salter add screen
    sudo salter add sensu
    sudo salter add shorewall
    sudo salter add slurm
    sudo salter add smokeping
    sudo salter add snmp
    sudo salter add sogo
    sudo salter add solr
    sudo salter add spark
    sudo salter add splunkforwarder
    sudo salter add squid
    sudo salter add stunnel
    sudo salter add sudo
    sudo salter add sugarcrm
    sudo salter add supervisor
    sudo salter add sysctl
    sudo salter add sysstat
    sudo salter add systemd
    sudo salter add template
    sudo salter add timezone
    sudo salter add tinc
    sudo salter add tmux
    sudo salter add tomcat -u vagrant
    sudo salter add twemproxy
    sudo salter add ufw
    sudo salter add ulog
    sudo salter add uwsgi
    sudo salter add vagrant
    sudo salter add varnish
    sudo salter add vault
    sudo salter add vim -u vagrant
    sudo salter add virtualenv -u vagrant
    sudo salter add vmbuilder
    sudo salter add vmware-tools
    sudo salter add vscode
    sudo salter add vsftpd
    sudo salter add webstorm -u vagrant
    sudo salter add wordpress -u vagrant
    sudo salter add xinetd
    sudo salter add yed
    sudo salter add zabbix
    sudo salter add zendserver
    sudo salter add zookeeper


.. _`saltstack-formulas`: https://github.com/saltstack-formulas
.. _`salt-formulas`: https://github.com/salt-formulas
.. _`eligundry`: https://github.com/eligundry/salt.eligundry.com
.. _`creative integrations`: https://github.com/noelmcloughlin/salter-overlay-demo

Design by: noelmcloughlin
