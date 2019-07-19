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
