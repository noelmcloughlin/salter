## SALT DESKTOP API

Description of solution Application Programming Interface (API).

### CLI

The command line interface is described now.

- <code>salter.sh</code>

  - Bash script to install/upgrade salstack software under sudo privledges.

- <code>/usr/local/bin/salter.sh.sh</code>

  - This script deploys a profile to the host. The profile, a yaml format, drives the automated cloning and deployment by Salt orchestrator. This script supports the following arguments-

    <code>-i  profilename</code>
        Mandatory. Specify scenario (i.e. 'macbook') corresponding to a SLS file in <code>/srv/salt/api/</code> directory. 

    <code>-u  loginname</code>
        Mandatory for developer profiles.

    <code>-lall Full debugging.</code>

### Example Default configuation values

The configuration is stored in <code>/srv/salt/api_config</code> directory. These files are salt-desktop verification of saltstack-formuals, plus customizations.

### GUI

The Graphical user interfaces is now described.

<code>/srv/salt/desktop/contrib/menu.py</code>

   - Python script to display a menu of software formulas and generate artefacts described in the next section.
<p>
<p>
<p>

# Profile API

Profile definitions are SLS / yaml format files located in <code>/srv/salt/desktop/api/</code> directory. Each profile contains a list of salt states individually documented at github.com/saltstack-formulas/[formula-name]-formula/README file. The following illustrates a profile (salt highstate)-

> cat /srv/salt/desktop/api/dev:

    <code>
        #supported states are documented in the upstream formula README file.
        #For example, https://github.com/saltstack-formulas/maven-formula/blob/master/README.rst
        #Format: YAML
        base:
          '*':
            - maven
            - maven.env
            - java.clean
            - java
      </code>
<p>

## Defaults

Example default configuration values (i.e. what worked) are maintained in the <code>/profiles/config.sls</code> file. Errors runing salt-desktop are typically caused by bad configuration or sytax in this file.

## Saltstack API
- https://docs.saltstack.com/en/latest/topics/pillar/index.html 
- https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html
