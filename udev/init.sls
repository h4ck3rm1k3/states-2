/etc/udev/rules.d/90-remote-wake.rules:
  file.managed:
    - source: salt://udev/90-remote-wake.rules
    - user: root
    - group: root
    - mode: 644