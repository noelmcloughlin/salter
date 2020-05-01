
chrony:
  ntpservers:
    # walkover firewalled ntp servers example
      {%- if salt['cmd.run']('ping -c3 192.168.2.2', output_loglevel='quiet') %}
    #- 192.168.2.2
      {%- endif %}
      {%- if salt['cmd.run']('ping -c3 192.168.2.22', output_loglevel='quiet') %}
    #- 192.168.2.22
      {%- endif %}
      {%- if salt['cmd.run']('ping -c3 192.168.4.44', output_loglevel='quiet') %}
    #- 192.168.4.44
      {%- endif %}
    # NIST ntp servers
      {%- if salt['cmd.run']('ping -c3 132.163.97.5', output_loglevel='quiet') %}
    - 132.163.97.5
      {%- endif %}
    # European ntp servers
      {%- if salt['cmd.run']('ping -c3 0.europe.pool.ntp.org', output_loglevel='quiet') %}
    - 0.europe.pool.ntp.org
      {%- endif %}
  options: iburst
  otherparams:
    - 'rtcsync'
    - 'makestep 10 3'
    - 'stratumweight 0'
    - 'bindcmdaddress 127.0.0.1'
    - 'bindcmdaddress ::1'
    - 'commandkey 1'
    - 'generatecommandkey'
    - 'noclientlog'
    - 'logchange 0.5'
