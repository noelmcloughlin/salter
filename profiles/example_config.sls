# Salt Desktop verified values
# CAUTION: Corrupte yaml in this file will break Salt
# The 'devsetup -u' argument replaces 'undefined_user' text below.

{%- set kernel_version = salt['cmd.run']('uname -r', output_loglevel='quiet') %}

default_user: undefined_user
java_home: /usr/local/lib/java

timezone:
  name: 'Europe/Berlin'
  utc: True

users:
  undefined_user:
    sudouser: True
    shell: /bin/bash
    optional_groups:
      - adm
      - wheel
      - docker
    #needs sudo privledges
    sudo_rules:
      - 'ALL=(ALL) ALL'

packages:
{% if grains.os_family == 'Debian' %}
  pips:
    wanted:
      - docker
    unwanted:
       - docker-py
{% endif %}
  pkgs:
   {# The same package name should appear once, for sanity #}
    unwanted:
        {# docker-formula #}
      - lxc-docker*
      - docker.io*
     {% if grains.os == 'Ubuntu' %}
      - unattended-upgrades
    held:
        {%- if grains.osmajorrelease|int >= 18 %}
      - xserver-xorg-core: '2:1.19*'
        {%- else %}
      - xserver-xorg-core: '2:1.18*'
        {%- endif %}
     {% endif %}
    wanted:
      - wget
      - curl
     {% if grains.os_family != 'MacOS' %}
        {# docker-formula #}
      - iptables
      - ca-certificates
     {% endif %}
   {% if grains.os_family == 'Debian' %}
         {# standard #}
      - lsb-core
      - vim
      - virt-what
      - ssh
      - update-motd
      - software-properties-common
         {# docker-formula #}
      - python-pip
      - apt-transport-https
      - python-apt
         {# citrix-linuxvda formula #}
     {% if grains.os == 'Ubuntu' %}
        {%- if grains.osmajorrelease|int >= 18 %}
      - libreadline7
        {%- endif %}
      - ubuntu-desktop
     {% endif %}
  {% elif grains.os_family == 'RedHat' %}
      - redhat-lsb-core
      - vim-minimal
        {# postgres.dev #}
      - perl-Time-HiRes
      - libicu-devel
      - perl-IPC-Run
      - perl-Test-Simple
        {# Samba #}
      - sssd-libwbclient
     {% if grains.os == 'Fedora' %}
      - lxde-common
      - python2-dnf-plugin-versionlock
      - python3-dnf-plugin-versionlock
     {% else %}
      - yum-plugin-versionlock
     {% endif %}
          {# docker-formula #}
      - python2-pip
  {% elif grains.os_family == 'Suse' %}
      - lsb-release
      - vim
         {# citrix-linuxvda formula #}
      - xorg-x11
      - xorg-x11-server
      - lxde-common
         {# docker-formula #}
      - python-pip
  {% elif grains.os_family == 'Arch' %}
      - lsb-release
      - vim
      - lxde-task
        {# custom #}
      - alien
      - subversion
      - psmisc
          {# docker-formula #}
      - python2-pip
  {% endif %}
  #    if grains.os != 'MacOS' 
  #snaps:
  #  wanted:
  #    - hello-world
  #  unwanted:
  #    - goodbye-world
  #    endif 

apache:
  lookup:
    version: '2.4'
    manage_service_states: False

maven:
  version: 3.2.5
  source_hash: sha1=41009327d5494e0e8970b25b77ffed8934cd7ca1
  orgdomain: example.com
  scmhost: svn01
  repohost: repository
  archetypes: http://repository.example.com/releases/my-archetype-catalog.xml

nginx:
  ng:
    install_from_repo: false
    install_from_phusionpassenger: false
    install_from_ppa: false
    ppa_version: 'stable'
    source_version: '1.10.0'

java:
  java_home: /usr/local/lib/java
  jre_lib_sec: /usr/local/lib/java/jre/lib/security/policy/
  uri: http://example.com/downloads/java/

  release: '8'
  major: '0'
  minor: '102'
  build: ''       #because we are not using oracle otn url
  dirhash: ''     #because we are not using oracle otn url
 
      {%- if grains.os == 'MacOS' %}
  source_url: http://example.com/downloads/java/jdk/8u102/jdk-8u102-macosx-x64.dmg
  source_hash: 'md5=9652fdf0b3387f1897369c7ec642f546'

  ## or JDK macos ##
  #source_url: http://download.example.com/java/8u202/jdk-8u202-macosx-x64.dmg       ## can be non-oracle url
  #source_hash: sha256=b41367948cf99ca0b8d1571f116b7e3e322dd1ebdfd4d390e959164d75b97c20

  ## or JRE macos ##
  # source_url: http://download.oracle.com/java/8u202/jre-8u202-macosx-x64.dmg       ## can be non-oracle url
  # source_hash: sha256=a11f6b4f952470fc2cf03abd34c66cbd770902a053f3f868369ae8886c5986f4
      {%- elif grains.kernel == 'Linux' %}
  source_url: http://example.com/downloads/java/jdk/8u102/jdk-8u102-linux-x64.tar.gz
  source_hash: 'md5=bac58dcec9bb85859810a2a6acba740b'

  ### CHECKSUMS: https://www.oracle.com/webfolder/s/digest/8u202checksum.html
  #source_url: http://download.example.com/java/8u202/jdk-8u202-linux-x64.tar.gz       ## can be non-oracle url
  #source_hash: sha256=9a5c32411a6a06e22b69c495b7975034409fa1652d03aeb8eb5b6f59fd4594e0

  ## or JRE linux ##
  # source_url: http://download.example.com/java/8u202/jre-8u202-linux-x64.tar.gz       ## can be non-oracle url
  # source_hash: sha256=9efb1493fcf636e39c94f47bacf4f4324821df2d3aeea2dc3ea1bdc86428cb82

  linux:
    #Increase priority for every version installed
    altpriority: {{ range(1, 9100000) | random }}
      {%- endif %}
  jce_url: http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
  dl:
    retries: 2
    interval: 60

sqlplus:
  oracle:
    uri: http://example.com/downloads/oracle/
    version: 12.2.0.1.0
    md5:
    {% if grains.os not in ('MacOS',) %}
      #linux.x64 package cksums
      basic: md5=d9639092e3dea2e023272e52e2bd42da
      sqlplus: md5=93ae87df1d08bb31da57443a416edc8c
      sdk: md5=077fa2f215185377ccb670de9ca1678f
  linux:
    #Increase priority for every version installed
    altpriority: {{ range(1, 9100000) | random }}
    {% else %}
      basic: md5=537713092a123b3f43d6f1a2be0fe53f
      sdk: md5=6791925e182d534a8143847263157d8f
      sqlplus: md5=0c23f99617f6c2d11ac6df1704c7cd85
    {% endif %}
  dl:
    retries: 2
    interval: 60
  prefs:
    tnsnamesurl:
    tnsnamesfile:

sqldeveloper:
  oracle:
    uri: http://example.com/downloads/oracle/
    version: 17.3.1.279.0537
    pkgs: ['sqldeveloper']
    md5:
     {% if grains.os == 'MacOS' %}
      sqldeveloper: md5=2969c67ea5b856655adff9b8695746f1
     {% else %}
      # linux/windows
      sqldeveloper: md5=5e077af62c1c5a526055cd9f810a3ee0
     {% endif %}
      sqlcl: md5=65862f2a970a363a62e1053dc8251078
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Increase priority for every version installed
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  dl:
    retries: 2
    interval: 60
  prefs:
    user: undefined_user
    xmlurl:
    xmldir:
    xmlfile: connections-with-password.xml
    connections_url: http://example.com/downloads/oracle/myconnections.xml

tomcat:
  {% set host_name = salt['grains.get']('hostname') %}
  {% set id = ['example.com','example.net'] %}

  # The Tomcat version can be overridden like so.
    ver: 8
    security: 'no'
    # The Java home directory can be overridden like so.
    # java_home: '/usr/lib/jvm/default-java'

    # Any parameter you may pass to the java app, you can pass it here,
    # without the preceding dash. The template builds the correct JAVA_OPTS
    # line, adding the dash.
    # Java's parameter don't follow a pattern (that I can see), so I think it's
    # the best way to build the string of opts.
    java_opts:
      - 'Djava.awt.headless=true'
      - 'Xmx128m'
      - 'XX:MaxPermSize=256m'
      - 'XX:+UseConcMarkSweepGC'
      - 'XX:+CMSIncrementalMode'
    # Change paths to correct locations
      - 'Dlog4j.configuration=file:/tmp/log4j.properties'
      - 'Dlogback.configurationFile=/tmp/logback.xml'
    jsp_compiler: javac
    logfile_days: 14
    logfile_compress: 1
    authbind: no
    expires_when: '2 weeks'

    limit:
      soft: 64000
      hard: 64000

     {% if grains.os not in ('Windows', 'MacOS',) %}
    linux:
      #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
      #Increase same value on each subsequent software installation.
      altpriority: {{ range(1, 9100000) | random }}
     {% endif %}

    connectors:
      example_connector:
        port: 8443
        protocol: 'org.apache.coyote.http11.Http11Protocol'
        connectionTimeout: 20000
        URIEncoding: 'UTF-8'
        redirectPort: 8443
        maxHttpHeaderSize: 8192
        maxThreads: 150
        minSpareThreads: 25
        enableLookups: 'false'
        disableUploadTimeout: 'true'
        acceptCount: 100
        scheme: https
        secure: 'true'
        clientAuth: 'false'
        sslProtocol: TLS
        SSLEnabled: 'false'
        #Change to realpath before setting "SSLEnabled: 'true'"
        keystoreFile: '/path/to/keystoreFile'
        keystorePass: 'somerandomtext'
    sites:
        {{ id[0] }}: # must be unique; used as an ID declaration in Salt; also used in the  template as {{ host_name }} if name is not declared
          name: {{ host_name }} # to use as "Host name=" in server.xml definitions. If not declared, ID declaration will be used
          appBase: ../webapps/javapp
          path: ''
          docBase: ../webapps/javapp
          alias: www.{{ id[0] }}
          host_parameters:
            unpackWARs: "true"
            autoDeploy: "true"
            deployXML: "false"
          reloadable: "true"
          debug: 0
        {{ id[1] }}:
          appBase: ../webapps/javapp2
          path: ''
          docBase: ../webapps/javapp2
          alias: www.{{ id[1] }}
          host_parameters:
            unpackWARs: "true"
            autoDeploy: "true"
          reloadable: "true"
          debug: 0
          valves:
            - className: org.apache.catalina.valves.AccessLogValve
              directory: logs
              prefix: localhost_access_log.
              fileDateFormat: yyyy-MM-dd-HH
              suffix: .log
              pattern: '%h %l %u %t &quot;%m http://%v%U %H&quot; %s %b &quot;%{Referer}i&quot; &quot;%{User-Agent}i&quot; %D'
            - className: org.apache.catalina.authenticator.SingleSignOn
    manager:
        # UPDATE: This version of the pillar file now supports multiple user acccounts and variable roles.  The previous version of this formula supported only a single user and fixed roles.
        roles:
          - manager-gui
          - manager-script
          - manager-jmx
          - manager-status
        users:
          saltuser1:
            passwd: RfgpE2iQwD
            roles: manager-gui,manager-script,manager-jmx,manager-status
          saltuser2:
            passwd: RfgpE2iQwD
            roles: manager-gui,manager-script,manager-jmx,manager-status
    context:
      # Let's you define multiple elements in the global context.xml file.
      # The state does not try to be clever about the correctness of what you add here,
      # just iterates over the dictionary of <Elements_types> and generates entries
      # in the file. Ie, the lines below will generate:
      #
      # <Environment
      #     name="env.first"
      #     value="first.text"
      #     type="java.lang.String"
      #     override="true"
      # />
      # <Environment
      #     name="env.second"
      #     value="second.value"
      #     type="some.other.type"
      #     override="false"
      # />
      # <Listener
      #     className="org.apache.catalina.security.SecurityListener"
      # />
      # <Listener
      #     className="org.apache.catalina.core.AprLifecycleListener"
      #     SSLEngine="on"
      # />
      # <Resource
      #     name="jdbc/__postgres"
      #     auth="Container"
      #     type="javax.sql.DataSource"
      #     driverClassName="org.postgresql.Driver"
      #     url="jdbc:postgresql://db.server/dbname"
      #     username="dbuser"
      #     password="aycaramba!"
      #     maxActive="20"
      #     maxIdle="10"
      #     maxWait="-1"
      # />
      # <ResourceLink
      #     name="linkToGlobalResource"
      #     global="simpleValue"
      #     type="java.lang.Integer"
      # />

      Environment:
        env.first:
          name: env.first
          value: first.text
          type: java.lang.String
          override: true
        env.second:
          name: env.second
          value: second.value
          type: some.other.type
          override: false
      Listener:
        first:
          className: org.apache.catalina.security.SecurityListener
        second:
          className: org.apache.catalina.core.AprLifecycleListener
          SSLEngine: on
      Resource:
        jdbc:
          name: jdbc/__postgres
          auth: Container
          type: javax.sql.DataSource
          driverClassName: org.postgresql.Driver
          url: jdbc:postgresql://db.server/dbname
          user: dbuser
          password: aycaramba!
          maxActive: 20
          maxIdle: 10
          maxWait: -1
      ResourceLink:
        any_name_here_will_be_ignored:
          name: linkToGlobalResource
          global: simpleValue
          type: java.lang.Integer
    other_contexts:
      'other-contexts':   # will be available at 'tomcat.conf_dir/Catalina/localhost/context'
        params:            # parameters to the context itself.
          docBase: /path/to/webapp
          debug: 1
          reloadable: 'true'
          crossContext: 'true'
        elements:          # elements take the same form as the default 'context' section above.
          Resource:
            jdbc:
              name: jdbc/__postgres
              auth: Container
              type: javax.sql.DataSource
              driverClassName: org.postgresql.Driver
              url: jdbc:postgresql://db.server/dbname
              user: dbuser
              password: aycaramba!
              maxActive: 20
              maxIdle: 10
              maxWait: -1

eclipse:
  epp:
    #java, jee, cpp, committers, php, dsl, javascript, modeling, rcp, parallel, testing, scout
    edition: java
    release: 2018-12
    version: R
  dl:
    retries: 2
    interval: 30
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
    #Increase same value on each subsequent software installation.
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    xmlurl:
    xmldir:
    xmlfile: eclipse-settings.xml
  plugins:
    svn:
      version: 1.9.3

  {% if grains.os not in ('Windows', 'MacOS',) %}
firewalld:
  enabled: True
  #default_zone: public
  services:
    linuxvda:
      short: linuxvda
      description: Citrix Linxu VDA
      ports:
        tcp:
          - 8585
          - 1494
          - 2598
          - 8008
        udp:
          - 8585
          - 1494
          - 2598

  zones:
    public:
      short: Public
      services:
        - http
        - https
        - ssh
        - ntp
        - linuxvda

    {%- if grains.os == 'Fedora' %}
    FedoraWorkstation:
      short: FedoraWorkstation
      services:
        - http
        - https
        - ssh
        - ntp
        - linuxvda
    {%- endif %}


resolver:
  ng:
    resolvconf:
      enabled: False
  domain: example.com
  nameservers:
    - 8.8.8.8
    - 1.1.1.1
  searchpaths:
    - example.com
  options:
    - rotate
    - timeout:1
    - attempts:5

chrony:
  ntpservers:
    # walkover firewalled ntp servers example
  {%- if salt['cmd.run']('ping -c3 192.168.2.2', output_loglevel='quiet') %}
    #- 192.168.2.2
  {%- endif %}
  {%- if salt['cmd.run']('ping -c3 192.168.2.22', output_loglevel='quiet') %}
    #- 192.168.2.22
  {%- endif %}
  {%- if salt['cmd.run']('ping -c3 192.168.4.44', output_loglevel='quiet') %}
    #- 192.168.4.44
  {%- endif %}
    # NIST ntp servers
  {%- if salt['cmd.run']('ping -c3 132.163.97.5', output_loglevel='quiet') %}
    - 132.163.97.5
  {%- endif %}
    # European ntp servers
  {%- if salt['cmd.run']('ping -c3 0.europe.pool.ntp.org', output_loglevel='quiet') %}
    - 0.europe.pool.ntp.org
  {%- endif %}
  options: iburst
  otherparams:
    - 'rtcsync'
    - 'makestep 10 3'
    - 'stratumweight 0'
    - 'bindcmdaddress 127.0.0.1'
    - 'bindcmdaddress ::1'
    - 'commandkey 1'
    - 'generatecommandkey'
    - 'noclientlog'
    - 'logchange 0.5'

samba:
  role: ROLE_DOMAIN_MEMBER
  conf:
    render:
      section_order: ['global', 'homes', 'printers', 'files',]
    sections:
      global:
        workgroup: EXAMPLE
        max log size: 50
        realm: EXAMPLE.COM
        security: ADS
        winbind expand groups: 0
  winbind:
    krb5_default_realm: EXAMPLE.COM

linuxvda:
  fqdn_resolver_alias: 'salt'
  enable_ntp_timesync: timedatectl set-ntp True
  domain: example.com
    ##Default to version 7.16 (dec2017) as version 1811 is not working on Ubuntu 18.04
    {%- if grains.os_family == 'RedHat' %}

  src_pkg: 'XenDesktopVDA-7.16.0.412-1.el7_x.x86_64.rpm'
  src_hash: 'sha256=8b75157869fda9db2a8bebeffee75619fcda4d9dcadac62f013d4f89a7a6ffe6'
  #src_pkg: LinuxVDA-1811.el7_x.rpm
  #src_hash: sha256=80a995c2c4a042fd57092b8a5bc69f3d50c0ec8a468d1edc817789eff480dfac

    {%- elif grains.os_family == 'Suse' %}

  src_pkg: 'XenDesktopVDA-7.16.0.412-1.sle12_x.x86_64.rpm'
  src_hash: 'sha256=57bd03ee4a01cce9a01571eba668b0dcc34787a9f7a4b8a637696172860206f7'
  #src_pkg: LinuxVDA-1811.sle12_x.rpm
  #src_hash: sha256=4120d9f4a8589a49fa34ac75c65c2e8ea639f464aea54bf553ea22c9eb27d0ef

    {%- elif grains.os == 'Ubuntu' %}

  src_pkg: 'xendesktopvda_7.16.0.412-1.ubuntu16.04_amd64.deb'
  src_hash: 'fc48ad39be54cae0034e9302908aa146'
  #src_pkg: LinuxVDA-1811.ubuntu16.04.deb
  #src_hash: sha256=cdc999d964fab391cd4680607d464d2619b7cd620995392edb3852c5db5ce715
    {%- endif %}

  citrix:
    uri: http://example.com/downloads/corpsys/xendesktop/
    variables:
      #CTX_XDL_VDA_PORT: 8585
      CTX_XDL_HDX_3D_PRO: N
      {% if grains.os_family == 'Debian' %}
      CTX_XDL_DDC_LIST: ctxdev01.example.com
      {% else %}
      CTX_XDL_DDC_LIST: dc01.example.com dc02.example.com
      {% endif %}
      # Set Y for dedicated desktop delivery model (VDI), N for 'server/shared' model.
      CTX_XDL_VDI_MODE: Y
      {%- if grains.os == 'Ubuntu' and grains.osmajorrelease|int < 18 %}
  xdping:
    archive: linux-xdping.tar
    hash: sha256=38cf8ff42cd0d610ba7323689046cd1492db912c9f722932e99c13869301186a
      {% endif %}


  {% endif %}

kerberos:
  krb5:
    libdefaults:
      default_realm: EXAMPLE.COM
      default_domain: example.com
      dns_lookup_realm: yes
      dns_lookup_kdc: false
      rdns: false
      forwardable: false
      proxiable: false
    realms:
      EXAMPLE.COM:
        kdc:
          - dc01.example.com
        admin_server: dc01.example.com
        master_kdc: dc01.example.com
    domain_realm:
      .example.com: EXAMPLE.COM
      example.com: EXAMPLE.COM

postgres:
  {% if grains.os == 'MacOS' %}
  # Set to 'postgresapp' (default) or 'homebrew' to install on MacOS
  use_upstream_repo: "'postgresapp'"
  {% else %}
  # Set False to use distro packaged postgresql.
  # Set True to use upstream postgresql.org repo for YUM/APT/ZYPP
  use_upstream_repo: False
  pkgs_extra:
    - postgresql-contrib

  #following is used by 'remove' states.
  upstream:
    purgeall: true
    releases: ['9.2', '9.3', '9.4', '9.5', '9.6', '10',]
    
  #Debian alternatives priority incremental. 0 disables feature.
  linux:
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}

  limits:
    soft: 64000
    hard: 64000

  conf_dir_mode: '0700'
  # Append the lines under this item to your postgresql.conf file.
  # Pay attention to indent exactly with 4 spaces for all lines.
  postgresconf: |
    listen_addresses = '*'  # listen on all interfaces

  # Path to the `pg_hba.conf` file Jinja template on Salt Fileserver
  pg_hba.conf: salt://postgres/templates/pg_hba.conf.j2

  # This section covers ACL management in the ``pg_hba.conf`` file.
  # acls list controls: which hosts are allowed to connect, how clients
  # are authenticated, which PostgreSQL user names they can use, which
  # databases they can access. Records take one of these forms:
  #
  #acls:
  #  - ['local', 'DATABASE',  'USER',  'METHOD']
  #  - ['host', 'DATABASE',  'USER',  'ADDRESS', 'METHOD']
  #  - ['hostssl', 'DATABASE', 'USER', 'ADDRESS', 'METHOD']
  #  - ['hostnossl', 'DATABASE', 'USER', 'ADDRESS', 'METHOD']
  #
  # The uppercase items must be replaced by actual values.
  # METHOD could be omitted, 'md5' will be appended by default.
  #
  # If ``acls`` item value is empty ('', [], null), then the contents of
  # ``pg_hba.conf`` file will not be touched at all.
  acls:
    - ['local', 'db1', 'localUser']
    - ['host', 'db2', 'remoteUser', '192.168.33.0/24']
  {# these are added for LinuxVDA formula #}
    - ['local', 'all', 'postgres', '', 'ident',]
    - ['local', 'citrix-confdb', 'root', '', 'ident',]
    - ['local', 'citrix-confdb', 'ctxsrvr', '', 'ident',]
    - ['local', 'citrix-confdb', 'guest', '', 'trust',]
    - ['host', 'citrix-confdb', 'ctxvda', '127.0.0.1/32', 'password',]
    - ['host', 'citrix-confdb', 'guest', '127.0.0.1/32', 'trust',]
    - ['host', 'citrix-confdb', 'ctxvda', '::1/128', 'password',]
    - ['host', 'citrix-confdb', 'guest', '::1/128', 'trust',]

  # Backup extension for configuration files, defaults to ``.bak``.
  # Set ``False`` to stop creation of backups when config files change.
  {%- if salt['status.time']|default(none) is callable %}
  config_backup: ".backup@{{ salt['status.time']('%y-%m-%d_%H:%M:%S') }}"
  {%- endif %}

  {%- if grains['init'] == 'unknown' %}

  # If Salt is unable to detect init system running in the scope of state run,
  # probably we are trying to bake a container/VM image with PostgreSQL.
  # Use ``bake_image`` setting to control how PostgreSQL will be started: if set
  # to ``True`` the raw ``pg_ctl`` will be utilized instead of packaged init
  # script, job or unit run with Salt ``service`` state.
  bake_image: True

  {%- endif %}

  # Create/remove users, tablespaces, databases, schema and extensions.
  # Each of these dictionaries contains PostgreSQL entities which
  # mapped to the ``postgres_*`` Salt states with arguments. See the Salt
  # documentation to get all supported argument for a particular state.
  #
  # Format is the following:
  #
  #<users|tablespaces|databases|schemas|extensions>:
  #  NAME:
  #    ensure: <present|absent>  # 'present' is the default
  #    ARGUMENT: VALUE
  #    ...
  #
  # where 'NAME' is the state name, 'ARGUMENT' is the kwarg name, and
  # 'VALUE' is kwarg value.
  #
  # For example, the Pillar:
  #
  #users:
  #  testUser:
  #    password: test
  #
  # will render such state:
  #
  #postgres_user-testUser:
  #  postgres_user.present:
  #    - name: testUser
  #    - password: test
  users:
    localUser:
      ensure: present
      password: '98ruj923h4rf'
      createdb: False
      createroles: False
      createuser: False
      inherit: True
      replication: False

    remoteUser:
      ensure: present
      password: '98ruj923h4rf'
      createdb: False
      createroles: False
      createuser: False
      inherit: True
      replication: False

    absentUser:
      ensure: absent

  # tablespaces to be created
  tablespaces:
    my_space:
      directory: /srv/my_tablespace
      owner: localUser

  # databases to be created
  databases:
    db1:
      owner: 'localUser'
      template: 'template0'
      lc_ctype: 'en_US.UTF-8'
      lc_collate: 'en_US.UTF-8'
    db2:
      owner: 'remoteUser'
      template: 'template0'
      lc_ctype: 'en_US.UTF-8'
      lc_collate: 'en_US.UTF-8'
      tablespace: 'my_space'
      # set custom schema
      schemas:
        public:
          owner: 'localUser'
      # enable per-db extension
      extensions:
        uuid-ossp:
          schema: 'public'

  # optional schemas to enable on database
  schemas:
    uuid_ossp:
      dbname: db1
      owner: localUser

  # optional extensions to install in schema
  extensions:
    uuid-ossp:
      schema: uuid_ossp
      maintenance_db: db1
    #postgis: {}

pycharm:
  jetbrains:
    product: PC
    edition: C
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    #See https://www.jetbrains.com/help/pycharm/exporting-and-importing-settings.html
    jarurl:
    jardir:
    jarfile: pycharm-settings.jar

intellij:
  jetbrains:
    edition: C
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    #See https://www.jetbrains.com/help/idea/exporting-and-importing-settings.html
    jarurl:
    jardir:
    jarfile: intellij-settings.jar

appcode:
  dl:
    retries: 1
    interval: 30
  prefs:
    user: undefined_user
    #group:
    #See https://www.jetbrains.com/help/objc/exporting-and-importing-preferences.html
    jarurl:
    jardir:
    jarfile: my-appcode-settings.jar

gogland:
  dl:
    retries: 1
    interval: 30
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
    #Increase same value on each subsequent software installation.
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    jarurl:
    jardir:
    jarfile: gogland-settings.jar

rubymine:
  dl:
    retries: 1
    interval: 30
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
    #Increase same value on each subsequent software installation.
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    #See https://www.jetbrains.com/help/rubymine/Settings_Preferences_Dialog.html
    jarurl:
    jardir:
    jarfile: rubymine-settings.jar

clion:
  dl:
    retries: 1
    interval: 30
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
    #Increase same value on each subsequent software installation.
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    #See https://www.jetbrains.com/help/clion/exporting-and-importing-settings.html
    jarurl:
    jardir:
    jarfile: clion-settings.jar

resharper:
  dl:
    retries: 1
    interval: 30
  prefs:
    user: undefined_user
    #group:
    #See: https://www.jetbrains.com/help/resharper/Sharing_Configuration_Options.html#upgrading
    jarurl:
    jardir:
    jarfile: resharper-settings.jar

webstorm:
  dl:
    retries: 1
    interval: 30
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
    #Increase same value on each subsequent software installation.
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    #See https://www.jetbrains.com/help/webstorm/exporting-and-importing-settings.html
    jarurl:
    jardir:
    jarfile: webstorm-settings.jar

datagrip:
  dl:
    retries: 1
    interval: 30
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
    #Increase same value on each subsequent software installation.
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    #See https://intellij-support.jetbrains.com/hc/en-us/community/posts/115000132064-How-can-I-import-data-sources-from-DataGrip-to-IDEA-
    xmlurl:
    xmldir:
    xmlfile: datagrip-settings.xml

rider:
  dl:
    retries: 1
    interval: 30
  {% if grains.os not in ('Windows', 'MacOS',) %}
  linux:
    #Enable Debian alternatives feature by setting nonzero 'altpriority' value here.
    #Increase same value on each subsequent software installation.
    altpriority: {{ range(1, 9100000) | random }}
  {% endif %}
  prefs:
    user: undefined_user
    #group:
    #See https://www.jetbrains.com/help/rider/Settings_Preferences_Dialog.html
    jarurl:
    jardir:
    jarfile: rider-settings.jar

# Docker containers
docker-containers:
  lookup:

    # example docker registry container (if you want your own docker registry, use this)
    registry:
       {%- if grains.os == 'Fedora' %}
      image: 'docker.io/registry:latest'
       {%- else %}
      image: "registry:latest"
       {%- endif %}
      cmd:
      # Pull image on service restart (useful if you override the same tag. example: latest)
      pull_before_start: True
      runoptions:
        - "-e REGISTRY_LOG_LEVEL=warn"
        - "-e REGISTRY_STORAGE=s3"
        - "-e REGISTRY_STORAGE_S3_REGION=us-west-1"
        - "-e REGISTRY_STORAGE_S3_BUCKET=my-bucket"
        - "-e REGISTRY_STORAGE_S3_ROOTDIRECTORY=/registry"
        - "--log-driver=syslog"
        - "-p 5000:5000"
        - "--rm"

    javapp:
      image: tomcat:latest
      cmd: 
      runoptions:
        - "-v /home/undefined_user/javapp:/javapp"
        - "-p 8888:8080"
        - "-it --rm"
      stopoptions:
        - -t 60

# Docker
docker-pkg:
  lookup:
    process_signature: /usr/bin/docker

    # config for sysvinit/upstart (for systemd, use drop-ins in your own states)
    config:
      - DOCKER_OPTS="-s btrfs --dns 8.8.8.8"
      - export http_proxy="http://10.20.30.40:3128"

# Docker Compose
docker:
  # version of docker-compose to install (defaults to latest)
  #compose_version: 1.9.0

  # Global functions for docker_container.running states
  containers:
    skip_translate: ports
    force_present: False
    force_running: True

  compose:
    registry-datastore:
      dvc: True
       {%- if grains.os == 'Fedora' %}
      image: &registry_image 'docker.io/registry:latest'
       {%- else %}
      image: &registry_image 'registry:latest'
       {%- endif %}
      container_name: &dvc 'registry-datastore'
      command: echo *dvc data volume container
      volumes:
        - &datapath '/registry'
    registry-service:
      image: *registry_image
      container_name: 'registry-service'
      volumes_from:
        - *dvc
      environment:
        SETTINGS_FLAVOR: 'local'
        STORAGE_PATH: *datapath
        SEARCH_BACKEND: 'sqlalchemy'
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY: '/registry'
      ports:
        - 127.0.0.1:5000:5000
      #restart: 'always'    # compose v1.9
      deploy:               # compose v3
        restart_policy:
          condition: on-failure
          delay: 5s
          max_attempts: 3
          window: 120s
    nginx-latest:
       {%- if grains.os == 'Fedora' %}
      image: 'docker.io/nginx:latest'
       {%- else %}
      image: 'nginx:latest'
       {%- endif %}
      container_name: 'nginx-latest'
      links:
        - 'registry-service:registry'
      ports:
        - '80:80'
        - '443:443'
      volumes:
        - /srv/docker-registry/nginx/:/etc/nginx/conf.d
        - /srv/docker-registry/auth/:/etc/nginx/conf.d/auth
        - /srv/docker-registry/certs/:/etc/nginx/conf.d/certs
      #restart: 'always'    # compose v2
      deploy:               # compose v3
        restart_policy:
          condition: on-failure
          delay: 5s
          max_attempts: 3
          window: 120s

lxd:
  containers:
    local:
      bootstraptest:
        opts:
          require:
          - {lxd_profile: lxd_profile_local_default}
          - {lxd_profile: lxd_profile_local_autostart}
          - {lxd_profile: lxd_profile_local_small}
          - {lxd_image: lxd_image_local_ubuntu_xenial_amd64}
        profiles: [default, autostart, small]
        running: true
        source: xenial/amd64
        bootstrap_scripts:
          - cmd: [ '/bin/sleep', '2' ]

          - src: salt://lxd/scripts/bootstrap.sh
            dst: /root/bootstrap.sh
            cmd: [ '/root/bootstrap.sh', 'bootstraptest', 'pcdummy.lan', 'salt.pcdummy.lan', 'true' ]

          - cmd: [ '/usr/bin/salt-call', 'state.apply' ]
      ubuntu-trusty:
        running: True
        source: trusty/amd64
        profiles:
          - default
          - autostart
          - shared_mount
        config:
          boot.autostart.priority: 1000
        opts:
          require:
            - {lxd_profile: lxd_profile_local_autostart}
            # {lxd_profile: lxd_profile_local_shared_mount}
            - {lxd_image: lxd_image_local_ubuntu_trusty_amd64}
      alpine-34:
        running: True
        source: alpine/3.4/amd64
        profiles:
          - default
          - autostart
          - small
        config:
          boot.autostart.priority: 1000
        opts:
          require:
            - {lxd_profile: lxd_profile_local_autostart}
            - {lxd_profile: lxd_profile_local_small}
            - {lxd_image: lxd_image_local_alpine_3_4_amd64}

  images:
    local:
      ubuntu_xenial_amd64:
        name: ubuntu/xenial/amd64 
        aliases:
          - xenial/amd64
        auto_update: true
        public: false
        source:
          name: ubuntu/xenial/amd64
          remote: images_linuxcontainers_org
      ubuntu_trusty_amd64:
        name: ubuntu/trusty/amd64
        aliases:
          - trusty/amd64
        auto_update: True
        public: False
        source:
          name: ubuntu/trusty/amd64
          remote: images_linuxcontainers_org
      alpine_3_4_amd64:
        name: alpine/amd64
        aliases:
          - alpine/3.4/amd64
        auto_update: true
        public: false
        source:
          name: alpine/3.4/amd64
          remote: images_linuxcontainers_org

  lxd:
    run_init: true
    init: {network_address: '[::]', network_port: 8443, trust_password: PassW0rd}
    config:
      password:
        key: core.trust_password 
        value: "PaSsW0rD"
        force_password: True    # Currently this is executed every time

  profiles:
    local:
      autostart:
        config:
          boot.autostart: 1
          boot.autostart.delay: 2
          boot.autostart.priority: 1
      default:
        devices:
          eth2:
            nictype: bridged
            parent: lxdbr0
            type: nic
      shared_mount:
        devices:
          shared_mount:
            type: "disk"
            # Source on the host
            source: "/home/shared"
            # Path in the container
            path: "home/shared"
      small:
        config:
          limits.cpu: 1
          limits.memory: 512MB
        device:
          root:
            limits.read: 20Iops
            limits.write: 10Iops

  python: {use_pip: False}
  #remotes:
  #  local: {cert: /root/.config/lxc/client.crt, key: /root/.config/lxc/client.key,
  #    password: PassW0rd, remote_addr: 'https://localhost:8443', type: lxd, verify_cert: false}

etcd:
  lookup:
    version: 3.2.18
  linux:
    altpriority: {{ range(1, 90000) | random }}
