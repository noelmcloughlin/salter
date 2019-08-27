=============
Salter: The meta package manager for macOS and Linux.
=============

Salter installs profiles of the stuff you need without fuss.

Installation
------------
```
curl -o salter.sh https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh && sudo bash salter.sh bootstrap && sudo bash salter.sh add salter
```

:Paste that in a Terminal prompt:
    The script explains what it will do and then pauses before it does it. Salter supports MacOS, FreeBSD, and GNU/Linux.

What does Salter do?
--------------------
:Salter installs profiles of stuff you need:
    ```sudo salter add intellij```

:Salter installs itself to /srv/salt and then symlinks inself to /usr/local/bin/salter:
    ```$ cd /usr/local/bin && ls -l salter```
    ```$ salter -> /srv/salt/salter/salter.sh```

:Trivally create your own Salter profiles:
    ```$ vi /srv/salt/namespaces/your/mystuff```
    
:Its Yaml so you can build lots of profiles and upstream your creations:
    ```  base:```
    ```    *:```
    ```      - nginx```
    ```      - intellij```
    ```      - kubernetes```
    ```      - chrome```

:Install your profile. It's all Git, and Saltstack underneath the bonnet:
    ```$ sudo salter add mystuff```

:Remove your profile:
    ```$ sudo salter remove mystuff```

* Preamble text unashamedly inspired by Homebrew (brew.sh)

Namespaces
==========
Pre-written salt states are maintained by open source communities upstream:

* `saltstack-formulas`_ (default)
* `salt-formulas`_ (future maybe)
* `eligundry`_ (why not)
* many more
 
.. _`saltstack-formulas`: https://github.com/saltstack-formulas
.. _`salt-formulas`: https://github.com/salt-formulas
.. _`eligundry`: https://github.com/eligundry/salt.eligundry.com

DevOps can store their own profiles in their own git repository (recommended).

Solutions
=========
The list of all downstream solutions using Salter is:

* `opensds`_ (salter adder)

.. _`opensds`: https://github.com/opensds/opensds

Avoiding maintaining your own Salter fork
==============
DevOps wanting to avoid maintaining their own "Salter" fork can consider `creative integrations`_ (see `contrib/overlay-salt.sh`).

.. _`creative integrations`: https://github.com/noelmcloughlin/salter-overlay-demo


Design by
=========
* noelmcloughlin
* Contributors


.. _`saltstack-formulas-profiles`: Saltstack-Formulas Profiles
===========================
The `saltstack-formulas`_ namespace supports at-least these profiles:

```$ sudo salter add accumulo```
```$ sudo salter add aegir```
```$ sudo salter add apache```
```$ sudo salter add appcode```
```$ sudo salter add apt```
```$ sudo salter add aptly```
```$ sudo salter add avahi```
```$ sudo salter add aws```
```$ sudo salter add backupninja```
```$ sudo salter add backuptocloud```
```$ sudo salter add bareos```
```$ sudo salter add barman```
```$ sudo salter add beats```
```$ sudo salter add beaver```
```$ sudo salter add bigtest```
```$ sudo salter add bind```
```$ sudo salter add bro```
```$ sudo salter add cassandra```
```$ sudo salter add ceph```
```$ sudo salter add cerebro```
```$ sudo salter add cert```
```$ sudo salter add chef```
```$ sudo salter add chrony```
```$ sudo salter add circus```
```$ sudo salter add ckan```
```$ sudo salter add clamav```
```$ sudo salter add clion```
```$ sudo salter add cloudfoundry```
```$ sudo salter add cobbler```
```$ sudo salter add cockroachdb```
```$ sudo salter add collectd```
```$ sudo salter add consul```
```$ sudo salter add couchdb```
```$ sudo salter add cron```
```$ sudo salter add crontab```
```$ sudo salter add datagrip```
```$ sudo salter add ddclient```
```$ sudo salter add deepsea```
```$ sudo salter add deepsea_post```
```$ sudo salter add dehydrated```
```$ sudo salter add dev```
```$ sudo salter add devstack```
```$ sudo salter add dhcpd```
```$ sudo salter add dirvish```
```$ sudo salter add django```
```$ sudo salter add dnsmasq```
```$ sudo salter add docker-compose```
```$ sudo salter add docker-containers```
```$ sudo salter add docker```
```$ sudo salter add dovecot```
```$ sudo salter add eclipse```
```$ sudo salter add elasticsearch```
```$ sudo salter add emacs```
```$ sudo salter add emby```
```$ sudo salter add epazote```
```$ sudo salter add epel```
```$ sudo salter add etcd```
```$ sudo salter add exim```
```$ sudo salter add fail2ban```
```$ sudo salter add filebeat```
```$ sudo salter add firewalld```
```$ sudo salter add fluentbit```
```$ sudo salter add flume```
```$ sudo salter add frr```
```$ sudo salter add gce```
```$ sudo salter add gerrit```
```$ sudo salter add git```
```$ sudo salter add gitlab```
```$ sudo salter add gitolite```
```$ sudo salter add goland```
```$ sudo salter add golang```
```$ sudo salter add grafana```
```$ sudo salter add graphite```
```$ sudo salter add graylog```
```$ sudo salter add hadoop```
```$ sudo salter add haproxy```
```$ sudo salter add helm```
```$ sudo salter add hostapd```
```$ sudo salter add hostsfile```
```$ sudo salter add hugo```
```$ sudo salter add icinga2```
```$ sudo salter add immortal```
```$ sudo salter add influxdb```
```$ sudo salter add intellij```
```$ sudo salter add iptables```
```$ sudo salter add iscsi```
```$ sudo salter add ius```
```$ sudo salter add java```
```$ sudo salter add jenkins```
```$ sudo salter add joomla```
```$ sudo salter add kafka```
```$ sudo salter add keepalived```
```$ sudo salter add kibana```
```$ sudo salter add kubernetes```
```$ sudo salter add latex```
```$ sudo salter add letsencrypt```
```$ sudo salter add librenms```
```$ sudo salter add libvirt```
```$ sudo salter add lighttpd```
```$ sudo salter add lldpd```
```$ sudo salter add locale```
```$ sudo salter add logrotate```
```$ sudo salter add logstash```
```$ sudo salter add lvm```
```$ sudo salter add lxc```
```$ sudo salter add lxd```
```$ sudo salter add lynis```
```$ sudo salter add macbook```
```$ sudo salter add mailhog```
```$ sudo salter add maven```
```$ sudo salter add memcached```
```$ sudo salter add mercurial```
```$ sudo salter add metricbeat```
```$ sudo salter add mirth```
```$ sudo salter add molten```
```$ sudo salter add mongodb```
```$ sudo salter add monit```
```$ sudo salter add moosefs```
```$ sudo salter add msdtc```
```$ sudo salter add munin```
```$ sudo salter add mysql```
```$ sudo salter add nagios```
```$ sudo salter add newrelic```
```$ sudo salter add nexus```
```$ sudo salter add nfs```
```$ sudo salter add nginx```
```$ sudo salter add node```
```$ sudo salter add nomad```
```$ sudo salter add ntp```
```$ sudo salter add nut```
```$ sudo salter add nvm```
```$ sudo salter add opendkim```
```$ sudo salter add openldap```
```$ sudo salter add openntpd```
```$ sudo salter add opensds```
```$ sudo salter add openssh```
```$ sudo salter add openvas```
```$ sudo salter add openvpn```
```$ sudo salter add os-hardening```
```$ sudo salter add owncloud```
```$ sudo salter add oxidized```
```$ sudo salter add packages```
```$ sudo salter add packer```
```$ sudo salter add pam```
```$ sudo salter add patchwork```
```$ sudo salter add perl```
```$ sudo salter add pfring```
```$ sudo salter add php```
```$ sudo salter add phpstorm```
```$ sudo salter add pimpmylog```
```$ sudo salter add pip```
```$ sudo salter add piwik```
```$ sudo salter add plex```
```$ sudo salter add postfix```
```$ sudo salter add postgres```
```$ sudo salter add powerdns```
```$ sudo salter add pppoe```
```$ sudo salter add proftpd```
```$ sudo salter add prometheus```
```$ sudo salter add pulp```
```$ sudo salter add pycharm```
```$ sudo salter add rabbitmq```
```$ sudo salter add redis```
```$ sudo salter add redmine```
```$ sudo salter add remi```
```$ sudo salter add resolver```
```$ sudo salter add rider```
```$ sudo salter add rinetd```
```$ sudo salter add rkhunter```
```$ sudo salter add rspamd```
```$ sudo salter add rsyncd```
```$ sudo salter add rsyslog```
```$ sudo salter add ruby```
```$ sudo salter add rubymine```
```$ sudo salter add rundeck```
```$ sudo salter add runit```
```$ sudo salter add salt```
```$ sudo salter add samba```
```$ sudo salter add schroot```
```$ sudo salter add screen```
```$ sudo salter add sensu```
```$ sudo salter add shorewall```
```$ sudo salter add slurm```
```$ sudo salter add smokeping```
```$ sudo salter add snmp```
```$ sudo salter add sogo```
```$ sudo salter add solr```
```$ sudo salter add spark```
```$ sudo salter add splunkforwarder```
```$ sudo salter add squid```
```$ sudo salter add stunnel```
```$ sudo salter add sudo```
```$ sudo salter add sugarcrm```
```$ sudo salter add supervisor```
```$ sudo salter add sysctl```
```$ sudo salter add sysstat```
```$ sudo salter add systemd```
```$ sudo salter add template```
```$ sudo salter add timezone```
```$ sudo salter add tinc```
```$ sudo salter add tmux```
```$ sudo salter add tomcat```
```$ sudo salter add twemproxy```
```$ sudo salter add ufw```
```$ sudo salter add ulog```
```$ sudo salter add uwsgi```
```$ sudo salter add vagrant```
```$ sudo salter add varnish```
```$ sudo salter add vault```
```$ sudo salter add vim```
```$ sudo salter add virtualenv```
```$ sudo salter add vmbuilder```
```$ sudo salter add vmware-tools```
```$ sudo salter add vsftpd```
```$ sudo salter add webstorm```
```$ sudo salter add wordpress```
```$ sudo salter add xinetd```
```$ sudo salter add zabbix```
```$ sudo salter add zendserver```
```$ sudo salter add zookeeper```
