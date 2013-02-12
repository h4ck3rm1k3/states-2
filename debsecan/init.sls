debsecan:
  pkg:
    - installed

/etc/cron.d/debsecan:
  file.managed:
    - source: salt://debsecan/etc/cron.d/debsecan
    - mode: 644
    - require:
        - pkg: logcheck
