/etc/rc.local:
  file.managed:
    - source: salt://misc/etc/rc.local-neptune
    - mode: 755
