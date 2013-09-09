znc:
  pkg.installed

/etc/iptables.d/50-znc.txt:
  file.managed:
    - source: salt://znc/iptables/50-znc.txt
    - require:
      - file: /etc/iptables.d
