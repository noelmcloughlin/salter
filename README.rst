==============
salt-desktop
==============

Salt Desktop is a tool for building and deploying software environments without fuss.

Profiles are an minimilistic way of describing a wanted software environment. They can be dynamically created, shared, and reused in a predictable manner. Configs are an interface designed to hold global values distributble to hosts. While profile defaults maybe sufficient, we often need to modify default configuration to suit site/personal specifics. Formulas are pre-written salt states developed and shared by open source communities.  If you are familar with yaml and want to inject dynamic profiles into your systems, this tool does that.  Support OS include FreeBSD, MacOS, and most GNU/Linux.

Install
=======

```
curl -o salter.sh https://raw.githubusercontent.com/saltstack-formulas/salt-desktop/master/installer.sh && sudo bash salter.sh -i salt
```

Deploy a system profile
========================

```
sudo /usr/local/bin/salter.sh -i <profile-name>
```

Profile

    base:
      "*":
        - ceph.repo
        - chrony
        - devstack
        - docker
        - etcd
        - golang
        - iscsi
        - kubernetes
        - grafana
        - webstorm
        - pycharm
        - kerberos


Config:

    kubernetes:
      pkg:
        use_upstream_source: True
      kubectl:
        version: 1.15.0
        pkg:
          binary:
            source_hash: ecec7fe4ffa03018ff00f14e228442af5c2284e57771e4916b977c20ba4e5b39  #linux amd64 binary
      minikube:
        version: 1.2.0


Formulas

* `saltstack-formulas repository`_ ( default)
* `salt-formulas repository`_

.. _`saltstack-formulas`: https://github.com/saltstack-formulas
.. _`salt-formulas`: https://github.com/salt-formulas


Integration
-----------

The architectural design aims to keep users focused on profiles and related configuration only. One integration pattern is to maintain business logic in a separate repository that includes this content-

  * ``profiles/`` director for your profiles

  * ``configs/`` directory for your config or empty.

  * ``formulas/`` directory for your private formulas or empty.

  * ``scripts/overlay-salt.sh`` script like the working example in `./contrib/` directory.


Your integration workflow becomes-

```
git clone https://git.example.com/repos/my-salt-profiles-and-configs.git
cd my-salt-profiles-and-configs/
sudo ./scripts/overlay-salt.sh
```


Notes
-----
The `overlay-salt.sh` script merges salt-desktop into your repository and integrates your artifacts into the initial install procedure. We have provided a working example in the `contrib/` directory.

salt-desktop is tested on python2 and python3 (default). This tool is reported to work on MacOS, FreeBSD, and most GNU/Linux.

formulas are tested by the respective developers.
