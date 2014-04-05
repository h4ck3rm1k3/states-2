/etc/iptables.d/50-madsonic.txt:
  file.managed:
    - source: salt://madsonic/iptables/50-madsonic.txt
    - template: jinja
    - require:
        - file: /etc/iptables.d

/usr/bin/madsonic-restart:
  file.managed:
    - source: salt://madsonic/bin/madsonic-restart
    - mode: 700
    - user: root
    - group: root
