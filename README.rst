=============
salt-desktop
=============

Salt Desktop is a tool for building and deploying system environments without fuss.

If you are familar with yaml and want to inject dynamic profiles into your systems, this tool does that. The architectural design aims to keep users focused on profiles and associated configuration..

Profiles are an minimilistic way of describing a wanted software environment. They can be dynamically created, shared, and reused in a predictable manner. Configs are an interface designed to hold global values distributble to hosts. While profile defaults maybe sufficient, we often need to modify default configuration to suit site/personal specifics. Formulas are pre-written salt states developed and shared by open source communities.

Install
=======

```
curl -o salter.sh https://raw.githubusercontent.com/saltstack-formulas/salt-desktop/master/installer.sh && sudo bash salter.sh -i bootstrap && sudo bash salter.sh -i salt
```

Deploy profiles
===============

This command deploys a profile (pre-shipped or custom-built)-

```
sudo /usr/local/bin/salter.sh -i <profile-name> [ -u loginname ]
```

Dedicated upstream repositories contain the building blocks for profiles-

* `saltstack-formulas repository`_ ( default)
* `salt-formulas repository`_

.. _`saltstack-formulas`: https://github.com/saltstack-formulas
.. _`salt-formulas`: https://github.com/salt-formulas

Integration recommendation
==========================

Separate your business logic artifacts from the consuming system. Keep your salt-desktop artifacts in a separate git repository. You can integrate salt-desktop with your repo as follows-

1. Create following directories in your repository.

  * ``profiles/`` directory for your profiles; can be contributed upstream

  * ``configs/`` directory for your config or empty.

  * ``formulas/`` directory for your private formulas or empty.

  * ``scripts/overlay-salt.sh`` script like the working example in `./contrib/` directory.

2. Move your pillars/states to these new directories.

3. Overlay salt-desktop::

    curl -o scripts/overlay-salt.sh https://raw.githubusercontent.com/saltstack-formulas/salt-desktop/master/contrib/overlay-salt.sh
    sudo ./scripts/overlay-salt.sh

See Reference Solution at https://github.com/noelmcloughlin/salt-desktop-overlay-demo


Notes
-----
The `overlay-salt.sh` script merges salt-desktop into your repository and integrates your artifacts into the initial install procedure. We have provided a working example in the `contrib/` directory.

salt-desktop is tested on python2 and python3 (default). This tool is reported to work on MacOS, FreeBSD, and most GNU/Linux.

formulas are tested by the respective developers.
