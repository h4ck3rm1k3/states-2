debsecan:
  pkg:
    - installed

/etc/cron.d/debsecan:
  file.managed:
    - source: salt://debsecan/cron.d/debsecan
    - mode: 644
    - require:
        - pkg: logcheck
