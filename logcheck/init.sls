logcheck:
  pkg:
    - installed

/etc/logcheck/logcheck.conf:
  file.managed:
    - source: salt://logcheck/logcheck.conf
    - user: logcheck
    - group: logcheck
    - require:
        - pkg: logcheck

/etc/logcheck/ignore.d.server/local-dhclient:
  file.managed:
    - source: salt://logcheck/ignore.server.d/local-dhclient
    - user: logcheck
    - group: logcheck
    - require:
        - pkg: logcheck

/etc/cron.d/logcheck:
  file.managed:
    - source: salt://logcheck/cron.d/logcheck
    - require:
        - pkg: logcheck
