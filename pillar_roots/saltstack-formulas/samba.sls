  {% if grains.os not in ('Windows', 'MacOS',) %}

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

  {%- endif %}
