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
