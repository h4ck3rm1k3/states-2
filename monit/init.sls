monit:
  pkg:
    - installed

  service.running:
    - enable: True
    - require:
      - pkg: monit
    - watch:
      - file: /etc/monit/monitrc

/etc/monit/monitrc:
  file.managed:
    - mode: 700
    - source: salt://monit/monitrc
    - require:
      - pkg: monit

/etc/logrotate.d/monit:
  file.managed:
    - source: salt://monit/logrotate/monit
    - require:
      - pkg: logrotate
