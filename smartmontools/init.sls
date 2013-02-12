smartmontools:
  pkg:
    - installed
  service:
    - running

/etc/defaults/smartmontools:
  file.managed:
    - source: salt://smartmontools/etc/defaults/smartmontools
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: smartmontools