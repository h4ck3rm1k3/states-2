sickbeard_dependencies:
  pkg.installed:
    - names:
      - python-cheetah

/etc/init.d/sickbeard:
  file.managed:
    - source: salt://sickbeard/sickbeard.init
    - mode: 755

/etc/default/sickbeard:
  file.managed:
    - source: salt://sickbeard/sickbeard.conf.jinja
    - template: jinja

/etc/iptables.d/50-sickbeard.txt:
  file.managed:
    - source: salt://sickbeard/iptables/50-sickbeard.txt
    - template: jinja
    - context:
      sickbeard_port: {{ pillar.get('sickbeard_port', '8888') }}
    - require:
        - file: /etc/iptables.d