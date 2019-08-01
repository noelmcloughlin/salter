.. _readme:

===============================================
salt-desktop for GNU/Linux, MacOS, FreeBSD
===============================================

Salt Desktop is a tool for building and deploying software environments without fuss.

If you are familar with yaml and want to inject dynamic profiles into your systems, this tool does that.

Profiles are an minimilistic way of describing a wanted software environment. They can be dynamically created, shared, and reused in a predictable manner. Here is what a profile looks like-

    #format: yaml
    base:
      '*':
        - apache
        - ceph.repo
        - chrony
        - devstack
        - docker
        - eclipse
        - etcd
        - golang
        - iscsi
        - kubernetes
        - webstorm
        - pycharm
        - goland
        - kerberos

Configs are an interface designed to hold global values distributble to hosts. While profile defaults maybe sufficient, we often need to modify default configuration according to site specifics. Here is a config example with kubernetes overrides-

    #format: yaml
    kubernetes:
      dir:
        binary: /opt/kubernetes
        source: /tmp/kubernetes
      pkg:
        use_upstream_source: True
      kubectl:
        version: '1.15.0'
        linux:
          altpriority: 1000
        pkg:
          binary:
            source_hash: ecec7fe4ffa03018ff00f14e228442af5c2284e57771e4916b977c20ba4e5b39  #linux amd64 binary
      minikube:
        version: '1.2.0'

Configs are stored in a standardised file system hierarchy-

    ls /srv/salt/community/saltstack-formulas/salt-desktop/pillar_roots/
       apache.sls  eclipse.sls   init.sls kerberos.sls  maven.sls    packages.sls  salt.sls  sqlplus.sls   users.sls
       chrony.sls  etcd.sls      java.sls linuxvda.sls  nginx.sls    postgres.sls  samba.sls  timezone.sls
       docker.sls  firewall.sls  jetbrains.sls  lxd.sls opensds.sls  resolver.sls  sqldeveloper.sls  tomcat.sls
       .. etc ...

Formulas are pre-written salt states developed and shared in open source communities. Here are examples-

* saltstack-formulas repository (tool default)
* salt-formulas repository (not integrated yet)
* ... other git repositories...

.. _`saltstack-formulas`: https://github.com/saltstack-formulas
.. _`salt-formulas`: https://github.com/salt-formulas

Initial install
===============

    curl -o salter.sh https://raw.githubusercontent.com/saltstack-formulas/salt-desktop/master/installer.sh && sudo bash salter.sh -i salt

This command downloads and installs salt. It builds the standard environment and finishes by deploying the default "salt" profile. Here is example output fro Archlinux-

    ... cut verbose stuff ...
    cloning salt-formula for SaltDesktop ...
    ... using fork: sillyboy, branch: fixes
    Branch 'fixes' set up to track remote branch 'fixes' from 'origin'.
    Switched to a new branch 'fixes'

    cloning salt-desktop for SaltDesktop ...

    + cp /srv/salt/community/saltstack-formulas/salt-desktop/.//file_roots/install/init.sls /srv/salt//top.sls
    + cp /srv/salt//community/your/file_roots/install/salt.sls /srv/salt//top.sls
    local:
        ----------
        base:
            - salt.pkgrepo
            - salt.minion
            - salt.formulas
    run salt: this takes a while, please be patient ...
    -------------
    Succeeded: 41
    Failed:     0
    -------------
    See full log in [ /tmp/install-saltstack-formulas-salt-desktop-salt/log.201908012240 ]
    ///////////////////////////////////////////////////////////////////////
              salt for SaltDesktop has completed
    //////////////////////////////////////////////////////////////////////


Usage
=====

    sudo /usr/local/bin/salter.sh -i <profile-name>

Examples
========

    sudo /usr/local/bin/salter.sh -i salt
    sudo /usr/local/bin/salter.sh -i docker
    sudo /usr/local/bin/salter.sh -i joindomain
    sudo /usr/local/bin/salter.sh -i sudo
    sudo /usr/local/bin/salter.sh -i java

Integration example
====================

The architectural design aims to keep users focused on profiles and related configuration only. To support this design goal, the recommended integration pattern is to maintain a separate repository to hold your personal or site-specific business logic-

Your repository includes at least these directories-

* profiles/ ..................... mandatory - use pre-supplied profiles and write your own.
* configs/ ...................... optional - recommended.
* formulas/ ..................... optional - not recommended (just use upstream repositories)
* scripts/overlay-salt.sh ....... optional - see example in ./salt-desktop/contrib/ 

Your integration workflow becomes-

    git clone https://git.example.com/repos/my-salt-profiles-and-configs.git
    cd my-salt-profiles-and-configs/
    sudo ./scripts/overlay-salt.sh

The `overlay-salt.sh` script merges salt-desktop into your repository and integrates your artifacts into the initial install procedure. We have provided a working example in the `contrib/` directory.

Note
----
salt-desktop is tested on python2 and python3 (default). This tool is reported to work on MacOS, FreeBSD, and most GNU/Linux.

formulas are tested by the respective developers.
