monit:
  pkg:
    - installed

  service.running:
    - enable: True
    - mode: 700
    - require:
      - pkg: monit
    - watch:
      - file: /etc/monit/monitrc

/etc/monit/monitrc:
  file.managed:
    - source: salt://monit/monitrc
    - require:
      - pkg: monit

/etc/logrotate.d/monit:
  file.managed:
    - source: salt://monit/logrotate/monit
    - require:
      - pkg: logrotate
