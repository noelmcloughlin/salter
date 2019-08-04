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
