lirc:
  pkg.installed

/etc/lirc/lircd.conf:
  file.managed:
    - source: salt://lirc/lircd.conf
    - mode: 644
    - require:
      - pkg: lircd

/etc/lirc/hardware.conf:
  file.managed:
    - source: salt://lirc/hardware.conf
    - mode: 644
    - require:
      - pkg: lircd
