/etc/init.d/couchpotato:
  file.managed:
    - source: salt://couchpotato/couchpotato.init
    - mode: 755

/etc/default/couchpotato:
  file.managed:
    - source: salt://couchpotato/couchpotato.default.jinja
    - template: jinja

/etc/iptables.d/50-couchpotato.txt:
  file.managed:
    - source: salt://couchpotato/iptables/50-couchpotato.txt
    - template: jinja
    - require:
        - file: /etc/iptables.d