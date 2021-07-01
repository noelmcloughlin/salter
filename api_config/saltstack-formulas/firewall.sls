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
  {% endif %}
