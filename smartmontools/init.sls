smartmontools:
  pkg:
    - installed
  service:
    - running

/etc/defaults/smartmontools:
  file.managed:
    - source: salt://smartmontools/smartmontools.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: smartmontools