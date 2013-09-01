/usr/bin/mill:
  file.managed:
    - source: salt://salt/bin/mill
    - mode: 700
    - user: root
    - group: root
    - require:
      - pkg: salt-minion

/etc/salt/minion:
  file.managed:
    - source: salt://salt/etc/salt/minion
    - mode: 640
    - user: root
    - group: root
    - require:
        - pkg: salt-minion

salt-minion:
  pkg:
    - installed
