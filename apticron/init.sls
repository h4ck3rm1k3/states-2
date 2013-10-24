apticron:
  pkg.installed

/etc/cron.d/apticron:
  file.managed:
    - source: salt://apticron/cron.d/apticron
    - mode: 644
    - require:
        - pkg: apticron
