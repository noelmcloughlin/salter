## SALT DESKTOP API

Description of solution Application Programming Interface (API).

### CLI

The command line interface is described now.

- <code>salt.sh</code>

  - Bash script to install/upgrade salstack software under sudo privledges.

- <code>/usr/local/bin/devsetup.sh</code>

  - Alias /usr/local/bin/setup. This bash script deploys a profile to the host. The profile, a yaml format, drives the automated cloning and deployment by Salt orchestrator. This script supports the following arguments-

    <code>-a  appname</code>
    Optional. Specify appname (i.e. 'java') corresponding to <code>/srv/salt/profiles/apps</code> directory. 

    <code>-s  stackname</code>
    Optional. Specify scenario (i.e. 'macbook') corresponding to <code>/srv/salt/profiles/stacks</code> directory. 

    <code>-u  loginname</code>
        Mandatory. Local, or Active Directory, account.

    <code>-lall Full debugging.</code>

### Example Default configuation values

The configuration is stored in <code>/srv/salt/profiles/username_config.sls</code>. This file is exact copy of <code>/srv/salt/profiles/config.sls</code> potentially customized by 'username'.

### GUI

The Graphical user interfaces is now described.

<code>- bin/menu.py</code>

   - Python script to display a menu of software formulas and generate artefacts described in the next section.
<p>
<p>
<p>
<p>

# Profile API

Profile definitions are yaml-formatted files located in the <code>/profiles</code> directory. Each profile contains a list of formula 'state' names documented at github.com/saltstack-formulas/[formula-name]-formula/README file. The following illustrates profile file format-

> cat ./profiles/stacks/dev:

    <code>
        #supported states are documented in the upstream formula README file.
        #For example, https://github.com/saltstack-formulas/maven-formula/blob/master/README.rst
        #Format: YAML
        base:
          '*':
            - example
            - example.config
            - example.users
        
            - maven
            - maven.env
        
            - sun-java
            - sun-java.env
      </code>
<p>

## Defaults

Example default configuration values (i.e. what worked) are maintained in the <code>/profiles/config.sls</code> file. Errors runing salt-desktop are typically caused by bad configuration or sytax in this file.

## Saltstack API
- https://docs.saltstack.com/en/latest/topics/pillar/index.html 
- https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html
