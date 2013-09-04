/usr/bin/sickbeard:
  file.managed:
    - source: salt://sickbeard/bin/sickbeard
    - mode: 755

/etc/iptables.d/50-sickbeard.txt:
  file.managed:
    - source: salt://sickbeard/iptables/50-sickbeard.txt
    - template: jinja
    - context:
      sickbeard_port: {{ pillar.get('sickbeard_port', '8888') }}
    - require:
        - file: /etc/iptables.d