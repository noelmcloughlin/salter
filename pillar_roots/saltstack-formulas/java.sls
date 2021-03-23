# -*- coding: utf-8 -*-
# vim: ft=yaml
---
java:
  provider: adopt     #adopt, amazon, graalvm, haikuvm, intellij, oracle, zulu
  identity:
    user: undefined_user
  environ:
    a: b
  linux:
    altpriority: {{ range(1, 100000) | random }}

  adopt:
    javaversion: 8u252-b09
    # javaversion: jdk-11.0.7+10
    # javaversion: jdk-11.0.7+10_openj9-0.20.0
    jvm: hotspot
    pkg:
      name: OpenJDK8U-jdk
      # name: OpenJDK8U-jre
      use_upstream_archive: true
      use_upstream_macapp: false
      archive:
                {%- if grains.kernel|lower == 'darwin' %}
        source_hash: 6e267893aae127a4bccfedb56d9893a891213a93de593a97f248629eaa0594ba  # jdk8
        # source_hash: f8206f0fef194c598de6b206a4773b2e517154913ea0e26c5726091562a034c8  # jre8
        # source_hash: 931a81f4bed38c48b364db57d4ebdd6e4b4ea1466e9bd0eaf8e0f1e47c4569e9  # jre11 mactgz
        # source_hash: 0941d739e3230d1d83dc1ee54cff6d17d90331e4f275d00739cb78fba41c5b96 # jre11openj9
                {%- elif grains.kernel|lower == 'linux' %}
        source_hash: 2b59b5282ff32bce7abba8ad6b9fde34c15a98f949ad8ae43e789bbd78fc8862  # jdk8
        # source_hash:  a93be303ed62398dba9acb0376fb3caf8f488fcde80dc62d0a8e46256b3adfb1  # jre8
        # source_hash: 74b493dd8a884dcbee29682ead51b182d9d3e52b40c3d4cbb3167c2fd0063503  # jre11 lintgz
        # source_hash: 08258a767a6953bde21d15ef3c08e776d83257afa4acc52b55c70e1ac02f0489  # jre11openj9
                {%- endif %}
  amazon:
    jvm: hotspot
    javaversion: 8.252.09.1
    # javaversion: 11.0.7.10.1
    # javaversion: 11.0.7+10
    # javaversion: 11.0.7+10_openj9-0.20.0
    pkg:
      use_upstream_archive: true
      archive:
               {%- if grains.kernel|lower == 'darwin' %}
        source_hash: 4ff460eefa2d3deabfbfd967aa06da99    # jdk8 tgz
        # source_hash: 645210984f3e20745d26e847611d004b  # jdk11 tgz
        # source_hash: a0de749c37802cc233ac58ffde68191a4dc985c71b626e7c0ff53944f743427f  # jdk11openj9
        # source_hash: 0ab1e15e8bd1916423960e91b932d2b17f4c15b02dbdf9fa30e9423280d9e5cc  # jdk11hotspot
        # source_hash: 931a81f4bed38c48b364db57d4ebdd6e4b4ea1466e9bd0eaf8e0f1e47c4569e9  # jre11hotspot
               {%- elif grains.kernel|lower == 'linux' %}
        source_hash: 7e9925dbe18506ce35e226c3b4d05613  # jre8 tgz
        # source_hash: 7fab667aba936ef21928ce5d079e2e4a  # jdk11 tgz
        # source_hash: 526e89f3014fec473b24c10c2464c1343e23703114983fd171b68b1599bba561  # jdk11openj9
        # source_hash: ee60304d782c9d5654bf1a6b3f38c683921c1711045e1db94525a51b7024a2ca  # jdk11hotspot
        # source_hash: 74b493dd8a884dcbee29682ead51b182d9d3e52b40c3d4cbb3167c2fd0063503  # jre11hotspot
               {%- endif %}
  intellij:
         {%- if grains.os_family|lower == 'macos' %}
    javaversion: 8u202b1490
         {%- else %}
    javaversion: 8u202b1491
         {%- endif %}
    # javaversion: 11b125
    pkg:
      name: jbsdk
      use_upstream_archive: true
      use_upstream_macapp: false
      use_upstream_package: false
      archive:
          {%- if grains.kernel|lower == 'darwin' %}
        source_hash: 4d00c0db25ca5e43970af68198b0086befd68da69dcab645790c402e63a1494b  # jdk8 mactgz
        # source_hash: 935226ed8b53baeb3cbccb37b1024ed8249c182dd83cf4c481204ca9f20893d7  # jdk11 tgz
          {%- elif grains.kernel|lower == 'linux' %}
        source_hash: 7c2d8a3cb0e7c6b35ea668f346429476b95929dd369b5336a70030490aeab768  # jdk8 lintgz
        # source_hash: 193323090df49097f11ca2fb24fee7af476a452be2ce4eba5f9c943c1b2e013c  # jdk11 tgz
          {%- endif %}
  oracle:
    javaversion: 8u251-b08
    url_md5: 3d5a2bb8f8d4428bbe94aed7ec7ae784
    # javaversion: 11.0.7+8
    # url_md5: 8c7daf89330c48f0b9e32f57169f7bac
    pkg:
      name: jdk
      # name: jre
      uri: http://download.oracle.com/otn-pub/java
                  {%- if grains.kernel|lower == 'darwin' %}
      use_upstream_macapp: true
      use_upstream_archive: false
      archive:
        source_hash: e9de0a98c8a239aa4ec463b3a0179c1c9aa8ad6cfc0fe344a8a81f82f1d20cad  # jdk11 mactgz
      macapp:
        source_hash: eef71e68ce9c2c7e3d7e910616e555b219cdd98f4fa59709279a40b639f1d212  # jdk8 dmg
        # source_hash: 32322f6401d70b54de2370cbd5597dbcd06c12293722b38551face88aba3ac99  # jre8 dmg
        # source_hash: 6be9325e83fa2a37a45cf918321aa23ed2ff8ef4597eff03b41684f0c4b05af6  # jdk11
                  {%- elif grains.kernel|lower == 'linux' %}
      use_upstream_archive: true
      archive:
        source_hash: 777a8d689e863275a647ae52cb30fd90022a3af268f34fc5b9867ce32f1b374e  # jkd8
        # source_hash: 92fc256da54af798dc34aeab837df816577f2c46dd111f9f94058c186d36f589  # jre8
        # source_hash: a7334a400fe9a9dbb329e299ca5ebab6ec969b5659a3a72fe0d6f981dbca0224  # jdk11
                 {%- endif %}
  zulu:
    javaversion: 8.0.252
    version: 8.46.0.19-ca-jdk
    # javaversion: 11.0.7+10
    # version: 11.39.15-ca-jdk
    pkg:
          {%- if grains.kernel|lower == 'darwin' %}
      use_upstream_macapp: true
      macapp:
        source_hash: 1fa97725adf5df15a84d835156d4ca35433af0d6b0a1aa724336152d4325b827  # jdk8 dmg
        # source_hash: 8322cb6498076f171ab5efa4101fe8207d9aa6517d1d743bbe4d753b67abc8cb  # jdk11 dmg
      use_upstream_archive: false
      archive:
        source_hash: 43570b0a6455a02d25b0c4937164560fdb0a9478f9010c583f510fa80881ce0b  # jdk8 tar.gz
          {%- elif grains.kernel|lower == 'linux' %}
      use_upstream_archive: true
      archive:
        source_hash: ab8a4194006f12dd48bf7f176ca7879706d3f8fc7d3208313a46cc9ee2270716  # jdk8
        # source_hash: df0de67998ac0c58b3c9e83c86e2a81daca05dc5adc189d942bc5d3f4691e749  # jdk11
          {%- endif %}
