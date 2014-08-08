lirc:
  pkg.installed

ir-keytable:
  pkg.installed

/etc/lirc/lircd.conf:
  file.managed:
    - source: salt://lirc/lircd.conf
    - mode: 644
    - require:
      - pkg: lirc

/etc/lirc/hardware.conf:
  file.managed:
    - source: salt://lirc/hardware.conf
    - mode: 644
    - require:
      - pkg: lirc

/etc/lirc/lircd.conf.mceusb:
  file.managed:
    - source: salt://lirc/lircd.conf.mceusb
    - mode: 644
    - require:
      - pkg: lirc

/etc/init/ir-keytable.conf:
  file.managed:
    - source: salt://lirc/ir-keytable.conf
    - mode: 644
    - require:
      - pkg: ir-keytable

/usr/share/X11/xorg.conf.d/10-disable-mce-keyboard.conf:
  file.managed:
    - source: salt://lirc/10-disable-mce-keyboard.conf
