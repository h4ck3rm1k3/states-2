logrotate:
  pkg:
    - installed

/etc/logrotate.d:
  file.directory:
    - require:
      - pkg: logrotate

/etc/logrotate.conf:
  file.managed:
    - source: salt://logrotate/logrotate.conf