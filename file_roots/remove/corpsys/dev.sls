#format: YAML
base:
  '*':
    - timezone.clean
        {%- if grains.os_family in ('RedHat',) %}
    - epel.clean
        {%- endif %}
    - packages.clean
    # example.config.clean
    # example.groups.clean
    - users.clean
    - postgres.clean
    - maven.clean
    - intellij.clean
    - pycharm.clean
    - eclipse.clean
    - sqlplus.clean
    - sqldeveloper.clean
