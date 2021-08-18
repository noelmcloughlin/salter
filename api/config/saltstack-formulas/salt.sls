salt:
  install_packages: False
  master:
    file_roots:
      base:
            {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
        - /usr/local/etc/salt/states
            {%- elif grains['kernel'] in ['Darwin',] %}
        - /usr/local/srv/salt
            {%- elif grains['kernel'] in ['Windows',] %}
        - c:\\salt\\srv\\salt
            {%- else %}
        - /srv/salt
            {%- endif %}
    pillar_roots:
      base:
            {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
        - /usr/local/etc/salt/pillaar
            {%- elif grains['kernel'] in ['Darwin',] %}
        - /usr/local/srv/pillar
            {%- elif grains['kernel'] in ['Windows',] %}
        - c:\\salt\\srv\\pillar
            {%- else %}
        - /srv/pillar
            {%- endif %}
  minion:
    file_roots:
      base:
            {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
        - /usr/local/etc/salt/states
            {%- elif grains['kernel'] in ['Darwin',] %}
        - /usr/local/srv/salt
            {%- elif grains['kernel'] in ['Windows',] %}
        - c:\\salt\\srv\\salt
            {%- else %}
        - /srv/salt
            {%- endif %}
    pillar_roots:
      base:
            {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
        - /usr/local/etc/salt/pillaar
            {%- elif grains['kernel'] in ['Darwin',] %}
        - /usr/local/srv/pillar
            {%- elif grains['kernel'] in ['Windows',] %}
        - c:\\salt\\srv\\pillar
            {%- else %}
        - /srv/pillar
            {%- endif %}
  ssh_roster:
    controller1:
      host: {{ grains.ipv4[0] or grains.ipv6[1] }}
      user: stack
      sudo: True
      priv: /etc/salt/ssh_keys/sshkey.pem
salt_formulas:
  git_opts:
    default:
      baseurl: https://github.com/saltstack-formulas
         {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
      basedir: /usr/local/etc/salt/states/namespaces/saltstack-formulas
            {%- elif grains['kernel'] in ['Darwin',] %}
      basedir: /usr/local/srv/salt/namespaces/saltstack-formulas
            {%- elif grains['kernel'] in ['Windows',] %}
      basedir: c:\\salt\\srv\\salt\\namespaces\\saltstack-formulas
         {%- else %}
      basedir: /srv/salt/namespaces/saltstack-formulas
         {%- endif %}
  basedir_opts:
    makedirs: True
    user: root
      {%- if grains['kernel'] in ['FreeBSD', 'OpenBSD', 'NetBSD'] %}
    group: wheel
      {%- elif grains['kernel'] not in ('Windows',) %}
    group: root
      {%- endif %}
    mode: 755
  minion_conf:
    create_from_list: True
  list:
    base:
     {{ '- epel-formula' if grains.os_family in ('RedHat',) else '' }}
     - salt-formula
     - openssh-formula
     - packages-formula
     - firewalld-formula
     - eclipse-formula
     - tomcat-formula
     - sqlplus-formula
     - sqldeveloper-formula
     - sun-java-formula
     - java-formula
     - users-formula
     - kubernetes-formula
     - cloudfoundry-formula
     - postgres-formula
     - jetbrains-intellij-formula
     - jetbrains-pycharm-formula
     - etcd-formula
     - ceph-formula
     - deepsea-formula
     - docker-formula
     - etcd-formula
     - firewalld-formula
     - helm-formula
     - iscsi-formula
     - lvm-formula
     - packages-formula
     - devstack-formula
     - golang-formula
     - memcached-formula
     - opensds-formula
     - mysql-formula
     - timezone-formula
     - resolver-formula
     - nginx-formula
     - mongodb-formula
     - apache-formula
     - prometheus-formula
     - grafana-formula
     - sysstat-formula
     - airflow-formula
     - redis-formula
     - rabbitmq-formula
     - hostsfile-formula
     - sudoers-formula
