#format: YAML

base:
  '*':
    - timezone
        {%- if grains.os_family in ('RedHat',) %}
    - epel
        {%- endif %}
    - packages
    # example.config
    # example.groups
    - users
    - users.sudo
    - users.bashrc
    - users.profile
    - users.user_files
    - postgres
    - maven
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
