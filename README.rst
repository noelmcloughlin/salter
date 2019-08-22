=============
Salter: The meta package manager for macOS and Linux.
=============

Salter installs profiles of the stuff you need without fuss.

Installation
------------
```
curl -o salter.sh https://raw.githubusercontent.com/saltstack-formulas/salter/master/salter.sh && sudo bash salter.sh -i bootstrap && sudo bash salter.sh -i salter
```

:Paste that in a Terminal prompt:
    The script explains what it will do and then pauses before it does it. Salter supports MacOS, FreeBSD, and GNU/Linux.

What does Salter do?
--------------------
:Salter installs profiles of stuff you need:
    ```sudo salter install intellij```

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
    ```$ sudo salter install mystuff```

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

* `opensds`_ (salter installer)

.. _`opensds`: https://github.com/opensds/opensds

No Salter fork
==============
DevOps desperate to avoid maintaining a fork of Salter inside their own company can try `creative integrations`_ (see the `contrib/overlay-salt.sh` script).

.. _`creative integrations`: https://github.com/noelmcloughlin/salter-overlay-demo

.. _`saltstack-formulas-profiles`: Saltstack-Formulas Profiles
===========================
Here is a list of profiles maintained by the `saltstack-formulas`_ namespace:

```$ sudo salter install accumulo```
```$ sudo salter install aegir```
```$ sudo salter install apache```
```$ sudo salter install appcode```
```$ sudo salter install apt```
```$ sudo salter install aptly```
```$ sudo salter install avahi```
```$ sudo salter install aws```
```$ sudo salter install backupninja```
```$ sudo salter install backuptocloud```
```$ sudo salter install bareos```
```$ sudo salter install barman```
```$ sudo salter install beats```
```$ sudo salter install beaver```
```$ sudo salter install bigtest```
```$ sudo salter install bind```
```$ sudo salter install bro```
```$ sudo salter install cassandra```
```$ sudo salter install ceph```
```$ sudo salter install cerebro```
```$ sudo salter install cert```
```$ sudo salter install chef```
```$ sudo salter install chrony```
```$ sudo salter install circus```
```$ sudo salter install ckan```
```$ sudo salter install clamav```
```$ sudo salter install clion```
```$ sudo salter install cloudfoundry```
```$ sudo salter install cobbler```
```$ sudo salter install cockroachdb```
```$ sudo salter install collectd```
```$ sudo salter install consul```
```$ sudo salter install couchdb```
```$ sudo salter install cron```
```$ sudo salter install crontab```
```$ sudo salter install datagrip```
```$ sudo salter install ddclient```
```$ sudo salter install deepsea```
```$ sudo salter install deepsea_post```
```$ sudo salter install dehydrated```
```$ sudo salter install dev```
```$ sudo salter install devstack```
```$ sudo salter install dhcpd```
```$ sudo salter install dirvish```
```$ sudo salter install django```
```$ sudo salter install dnsmasq```
```$ sudo salter install docker-compose```
```$ sudo salter install docker-containers```
```$ sudo salter install docker```
```$ sudo salter install dovecot```
```$ sudo salter install eclipse```
```$ sudo salter install elasticsearch```
```$ sudo salter install emacs```
```$ sudo salter install emby```
```$ sudo salter install epazote```
```$ sudo salter install epel```
```$ sudo salter install etcd```
```$ sudo salter install exim```
```$ sudo salter install fail2ban```
```$ sudo salter install filebeat```
```$ sudo salter install firewalld```
```$ sudo salter install fluentbit```
```$ sudo salter install flume```
```$ sudo salter install frr```
```$ sudo salter install gce```
```$ sudo salter install gerrit```
```$ sudo salter install git```
```$ sudo salter install gitlab```
```$ sudo salter install gitolite```
```$ sudo salter install goland```
```$ sudo salter install golang```
```$ sudo salter install grafana```
```$ sudo salter install graphite```
```$ sudo salter install graylog```
```$ sudo salter install hadoop```
```$ sudo salter install haproxy```
```$ sudo salter install helm```
```$ sudo salter install hostapd```
```$ sudo salter install hostsfile```
```$ sudo salter install hugo```
```$ sudo salter install icinga2```
```$ sudo salter install immortal```
```$ sudo salter install influxdb```
```$ sudo salter install intellij```
```$ sudo salter install iptables```
```$ sudo salter install iscsi```
```$ sudo salter install ius```
```$ sudo salter install java```
```$ sudo salter install jenkins```
```$ sudo salter install joomla```
```$ sudo salter install kafka```
```$ sudo salter install keepalived```
```$ sudo salter install kibana```
```$ sudo salter install kubernetes```
```$ sudo salter install latex```
```$ sudo salter install letsencrypt```
```$ sudo salter install librenms```
```$ sudo salter install libvirt```
```$ sudo salter install lighttpd```
```$ sudo salter install lldpd```
```$ sudo salter install locale```
```$ sudo salter install logrotate```
```$ sudo salter install logstash```
```$ sudo salter install lvm```
```$ sudo salter install lxc```
```$ sudo salter install lxd```
```$ sudo salter install lynis```
```$ sudo salter install macbook```
```$ sudo salter install mailhog```
```$ sudo salter install maven```
```$ sudo salter install memcached```
```$ sudo salter install mercurial```
```$ sudo salter install metricbeat```
```$ sudo salter install mirth```
```$ sudo salter install molten```
```$ sudo salter install mongodb```
```$ sudo salter install monit```
```$ sudo salter install moosefs```
```$ sudo salter install msdtc```
```$ sudo salter install munin```
```$ sudo salter install mysql```
```$ sudo salter install nagios```
```$ sudo salter install newrelic```
```$ sudo salter install nexus```
```$ sudo salter install nfs```
```$ sudo salter install nginx```
```$ sudo salter install node```
```$ sudo salter install nomad```
```$ sudo salter install ntp```
```$ sudo salter install nut```
```$ sudo salter install nvm```
```$ sudo salter install opendkim```
```$ sudo salter install openldap```
```$ sudo salter install openntpd```
```$ sudo salter install opensds```
```$ sudo salter install openssh```
```$ sudo salter install openvas```
```$ sudo salter install openvpn```
```$ sudo salter install os-hardening```
```$ sudo salter install owncloud```
```$ sudo salter install oxidized```
```$ sudo salter install packages```
```$ sudo salter install packer```
```$ sudo salter install pam```
```$ sudo salter install patchwork```
```$ sudo salter install perl```
```$ sudo salter install pfring```
```$ sudo salter install php```
```$ sudo salter install phpstorm```
```$ sudo salter install pimpmylog```
```$ sudo salter install pip```
```$ sudo salter install piwik```
```$ sudo salter install plex```
```$ sudo salter install postfix```
```$ sudo salter install postgres```
```$ sudo salter install powerdns```
```$ sudo salter install pppoe```
```$ sudo salter install proftpd```
```$ sudo salter install prometheus```
```$ sudo salter install pulp```
```$ sudo salter install pycharm```
```$ sudo salter install rabbitmq```
```$ sudo salter install redis```
```$ sudo salter install redmine```
```$ sudo salter install remi```
```$ sudo salter install resolver```
```$ sudo salter install rider```
```$ sudo salter install rinetd```
```$ sudo salter install rkhunter```
```$ sudo salter install rspamd```
```$ sudo salter install rsyncd```
```$ sudo salter install rsyslog```
```$ sudo salter install ruby```
```$ sudo salter install rubymine```
```$ sudo salter install rundeck```
```$ sudo salter install runit```
```$ sudo salter install salt```
```$ sudo salter install samba```
```$ sudo salter install schroot```
```$ sudo salter install screen```
```$ sudo salter install sensu```
```$ sudo salter install shorewall```
```$ sudo salter install slurm```
```$ sudo salter install smokeping```
```$ sudo salter install snmp```
```$ sudo salter install sogo```
```$ sudo salter install solr```
```$ sudo salter install spark```
```$ sudo salter install splunkforwarder```
```$ sudo salter install squid```
```$ sudo salter install stunnel```
```$ sudo salter install sudo```
```$ sudo salter install sugarcrm```
```$ sudo salter install supervisor```
```$ sudo salter install sysctl```
```$ sudo salter install sysstat```
```$ sudo salter install systemd```
```$ sudo salter install template```
```$ sudo salter install timezone```
```$ sudo salter install tinc```
```$ sudo salter install tmux```
```$ sudo salter install tomcat```
```$ sudo salter install twemproxy```
```$ sudo salter install ufw```
```$ sudo salter install ulog```
```$ sudo salter install uwsgi```
```$ sudo salter install vagrant```
```$ sudo salter install varnish```
```$ sudo salter install vault```
```$ sudo salter install vim```
```$ sudo salter install virtualenv```
```$ sudo salter install vmbuilder```
```$ sudo salter install vmware-tools```
```$ sudo salter install vsftpd```
```$ sudo salter install webstorm```
```$ sudo salter install wordpress```
```$ sudo salter install xinetd```
```$ sudo salter install zabbix```
```$ sudo salter install zendserver```
```$ sudo salter install zookeeper```
