.. _readme:

Salt Desktop
================

Salt Desktop orchestrates useful software onto Linux/FreeBSD/MacOS without fuss.

HOSTED AT https://github.com/saltstack-formulas/salt-desktop !!!!!!!

Quick start
===========

Install salter on MacOS, FreeBSD, or GNU/Linux (Ubuntu/Debian/CentOS/SuSE)::

    curl -o salt.sh https://raw.githubusercontent.com/saltstack-formulas/salt-desktop/master/bin/installer.sh && sudo bash salter.sh

Customize pillar data for you site (i.e. set dns/ntp/domain/domain, etc)::

    sudo -s
    cd /srv/salt/community/saltstack-formulas/salt-desktop/pillar_roots/saltstack-formulas/
    ls
       apache.sls  eclipse.sls   init.sls kerberos.sls  maven.sls    packages.sls  salt.sls  sqlplus.sls   users.sls
       chrony.sls  etcd.sls      java.sls linuxvda.sls  nginx.sls    postgres.sls  samba.sls  timezone.sls
       docker.sls  firewall.sls  jetbrains.sls  lxd.sls opensds.sls  resolver.sls  sqldeveloper.sls  tomcat.sls

Menu
====

Provision a Desktop via Menu::

    sudo /usr/local/bin/salter.sh -u username


.. image:: design_specs/menu.png
   :target: https://github.com/saltstack-formulas/salt-desktop/blob/master/bin/menu.py
   :scale: 25 %
   :alt: Sample Menu


states
=======

Provision Linux Developer desktop (with oracle jdk and tomcat)::

      sudo /usr/local/bin/salter.sh -u username -i dev

OR .. provision Linux Developer desktop (without oracle jdk/tomcat)::

      sudo /usr/local/bin/salter.sh -u username -i corpsys/dev

OR .. provision MacBook Developer desktop::

      sudo /usr/local/bin/salter.sh -u username -i macbook

OR .. join Linux host to Active Directory::

      sudo /usr/local/bin/salter.sh -u domainadm -r corpsys/joindomain  #clean

      sudo /usr/local/bin/salter.sh -u domainadm -i corpsys/joindomain  #install

      sudo net ads join EXAMPLE.COM -U nmcloughlin

      sudo kinit -k UPPERCASE_HOSTNAME\\$@EXAMPLE.COM   # On failure retry after few minutes

      sudo systemctl restart winbind

AND .. provision Citrix LinuxVDA::

      sudo /usr/local/bin/salter.sh -u domainadm -i corpsys/linuxvda


OR remove postgres::

      sudo /usr/local/bin/salter.sh -u username -a postgres/remove

OR ... cleaninstall postgres:

      sudo /usr/local/bin/salter.sh -u username -a postgres/cleaninstall


OR ... define your own...::


ecosystem
=========

At least the following software, hosted at https://github.com/saltstack-formulas, are verfied with Salt-Desktop. All software downloads are checksum verified and can be stored on your internal network.

========================  =====  =====  ==========================
| Upstream formula        Linux  MacOS  Notes
========================  =====  =====  ==========================
| apache                   yes           
| ceph.repo                yes           
| chrony                   yes           
| linuxVda                 yes           
| deepsea                  yes           
| devstack                 yes          and OSC CLI
| docker                   yes                 
| eclipse                  yes    yes    
| cloudfoundry             yes    yes    
| etcd                     yes    yes    
| etcd.docker              yes    yes    
| firewalld                yes                 
| golang                   yes                 
| grafana                  yes    yes    
| hadoop                   yes                 
| iscsi                    yes                 
| jetbrains-intelliJ       yes    yes    
| jetbrains-datagrip       yes    yes    
| jetbrains-phpstorm       yes    yes    
| jetbrains-webstorm       yes    yes    
| jetbrains-pycharm        yes    yes    
| jetbrains-goland         yes    yes    
| kerberos                 yes                 
| lxd                      yes                 
| lvm                      yes                 
| maven                    yes    yes    
| mysql                    yes    yes   and mariaDB, workbench
| mongodb                  yes    yes   and BI connector
| opensds                  yes                 
| packages                 yes    yes    
| postgres                 yes    yes    
| prometheus               yes    yes    
| resolver                 yes                 
| salt                     yes    yes    
| samba                    yes                 
| sqlplus                  yes    yes    
| sqldeveloper             yes    yes    
| sun-java                 yes    yes   and JRE/JDK/JCE
| timezone                 yes                 
| tomcat                   yes    yes    
| users                    yes                 
========================  =====  =====  ==========================




EXAMPLES
========

Join Active Directory Domain and setup Citrix Linux VDA::

    bash
    sudo salter.sh -u domainadm -i corpsys/joindomain-cleanup; sudo salter.sh -u domainadm -i corpsys/joindomain

    custom choice [ stacks/corpsys/joindomain ] selected
    Logging to [ /tmp/install-saltstack-formulas-salt-desktop-joindomain/log.201804110644 ]
    Orchestrating things, please be patient ...
    Summary for local
    --------------
    Succeeded: 127 (changed=98)
    Failed:      0
    Warnings:    1
    --------------


    domainadm@myhost4:~$ sudo net ads join EXAMPLE.COM -U nmcloughlin
    Enter nmcloughlin password:
    Using short domain name -- EXAMPLE
    Joined MYHOST4 to dns domain example.com
    DNS Update for myhost4.example.com failed: ERROR_DNS_GSS_ERROR
    DNS update failed: NT_STATUS_UNSUCCESSFUL

    domainadm@myhost4:~$ sudo kinit -k MYHOST4\$@EXAMPLE.COM
    domainadm@myhost4:~$ sudo systemctl restart winbind


    domainadm@myhost4:~$ sudo /usr/local/bin/salter.sh -u domainadm -i corpsys/linuxvda
    custom choice [ stacks/corpsys/linuxvda ] selected
    Logging to [ /tmp/install-saltstack-formulas-salt-desktop-linuxvda/log.201804110804 ]
    Orchestrating things, please be patient ...
    Summary for local
    --------------
    Succeeded: 18 (changed=10)
    Failed:     0
    --------------


Sudo access::

    bash
    sudo salter.sh -u jdoe -a sudo

    custom choice [ apps/sudo ] selected
    Logging to [ /tmp/install-saltstack-formulas-salt-desktop-sudo/log.201804110702 ]
    Orchestrating things, please be patient ...

    Summary for local
    -------------
    Succeeded: 11 (changed=5)
    Failed:     2
    -------------
    Total states run:     13
    Total run time:   25.748 s
    See full log in [ /tmp/install-saltstack-formulas-salt-desktop-sudo/log.201804110702 ]
