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
