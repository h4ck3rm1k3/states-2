monit:
  pkg:
    - installed

  service.running:
    - enable: True
    - watch:
      - file: /etc/monit/monitrc

/etc/monit/monitrc:
  file.managed:
    - source: salt://monit/monitrc
    - require:
      - pkg: monit
