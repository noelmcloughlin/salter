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
