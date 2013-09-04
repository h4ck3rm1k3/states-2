logcheck:
  pkg:
    - installed

/etc/logcheck/logcheck.conf:
  file.managed:
    - source: salt://logcheck/logcheck.conf
    - require:
        - pkg: logcheck

/etc/logcheck/ignore.d.server/local-avahi-daemon:
  file.managed:
    - source: salt://logcheck/ignore.server.d/local-avahi-daemon
    - require:
        - pkg: logcheck

/etc/logcheck/ignore.d.server/local-dhclient:
  file.managed:
    - source: salt://logcheck/ignore.server.d/local-dhclient
    - require:
        - pkg: logcheck

/etc/logcheck/cron.d/logcheck:
  file.managed:
    - source: salt://logcheck/cron.d/logcheck
    - require:
        - pkg: logcheck
