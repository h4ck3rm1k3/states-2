logcheck:
  pkg:
    - installed

/etc/logcheck/logcheck.conf:
  file.managed:
    - source: salt://logcheck/etc/logcheck.conf
    - require:
        - pkg: logcheck

/etc/logcheck/ignore.d.server/local-avahi-daemon:
  file.managed:
    - source: salt://logcheck/etc/logcheck/ignore.server.d/local-avahi-daemon
    - require:
        - pkg: logcheck

/etc/logcheck/ignore.d.server/local-iptables:
  file.managed:
    - source: salt://logcheck/etc/logcheck/ignore.server.d/local-iptables
    - require:
        - pkg: logcheck

/etc/logcheck/cron.d/logcheck:
  file.managed:
    - source: salt://logcheck/etc/cron.d/logcheck
    - require:
        - pkg: logcheck
