base:
  '*':
    - timezone.clean
       {%- if grains.os_family in ('RedHat',) %}
    - epel.clean
       {%- endif %}
    - packages.clean
    - users.clean
    - postgres.clean
    - maven.clean
    # apache.clean
    - intellij.clean
    - pycharm.clean
    - eclipse.clean
    - sqlplus.clean
    - sqldeveloper.clean
    - docker.clean
    - charles.clean
    - chrome.clean
    - vscode.clean
    - yed.clean
    - dbeaver.clean
    - node.clean
    - insomnia.clean
    - postman.clean
