salt-minion:
  pkg:
    - installed

/etc/salt/minion:
  file.managed:
    - source: salt://salt/minion.conf
    - mode: 640
    - user: root
    - group: root
    - require:
        - pkg: salt-minion

/usr/bin/ppr:
  file.managed:
    - source: salt://salt/bin/ppr
    - mode: 700
    - user: root
    - group: root
    - require:
      - pkg: salt-minion
