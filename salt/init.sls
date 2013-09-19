/usr/bin/cho:
  file.managed:
    - source: salt://salt/bin/cho
    - mode: 700
    - user: root
    - group: root
    - require:
      - pkg: salt-minion

/etc/salt/minion:
  file.managed:
    - source: salt://salt/minion
    - mode: 640
    - user: root
    - group: root
    - require:
        - pkg: salt-minion

salt-minion:
  pkg:
    - installed
