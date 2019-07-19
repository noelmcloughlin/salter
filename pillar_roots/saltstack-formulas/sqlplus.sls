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
