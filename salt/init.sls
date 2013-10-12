/usr/bin/ppr:
  file.managed:
    - source: salt://salt/bin/ppr
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
