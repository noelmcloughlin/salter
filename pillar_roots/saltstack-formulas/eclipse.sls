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
