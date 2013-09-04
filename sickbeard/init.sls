/usr/bin/sickbeard:
  file.managed:
    - source: salt://sickbeard/bin/sickbeard
    - mode: 755
