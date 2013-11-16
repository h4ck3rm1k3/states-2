/etc/logrotate.d/salt-common:
  file.managed:
    - source: salt://salt/logrotate/salt-common
    - require:
      - pkg: logrotate
