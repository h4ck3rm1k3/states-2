salt-minion:
  pkg:
    - installed

  service.running:
    - enabled: True
    - watch:
        - file: /etc/salt/minion

/etc/salt/minion:
  file.managed:
    - source: salt://salt/minion.conf
    - mode: 640
    - user: root
    - group: root
    - require:
        - pkg: salt-minion
