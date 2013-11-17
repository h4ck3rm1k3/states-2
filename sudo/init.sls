sudo:
  pkg:
    - installed

/etc/sudoers.d/wheel:
  file.managed:
    - source: salt://sudo/wheel
    - user: root
    - group: root
    - mode: 440
    - require:
      - pkg: sudo