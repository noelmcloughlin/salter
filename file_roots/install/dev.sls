base:
  '*':
    - timezone
       {%- if grains.os_family in ('RedHat',) %}
    - epel
       {%- endif %}
    - packages
    - users
    - users.sudo
    - users.bashrc
    - users.profile
    - users.user_files
    - postgres
    - maven
    # apache
    # apache.config
    # apache.modules
    # apache.mod_ssl
    - intellij
    - pycharm
    - eclipse
    - eclipse.developer
    - eclipse.plugins
    - sqlplus
    - sqldeveloper
    {% if grains.os not in ('MacOS', 'Windows',) %}
    - eclipse.linuxenv
    - sqlplus.linuxenv
    - intellij.linuxenv
    - pycharm.linuxenv
    - sqldeveloper.linuxenv
    {% endif %}
    - docker
    - charles
    - chrome
    - vscode
    - yed
    - dbeaver
    - node
    - insomnia
    - postman
