include:
  - salt.common

salt-minion:
  pkg:
    - installed

  service.running:
    - enable: True
    - watch:
      - file: /etc/salt/minion

/etc/salt/minion:
  file.managed:
    - source: salt://salt/minion.conf
    - template: jinja
    - mode: 640
    - user: root
    - group: root
    - require:
        - pkg: salt-minion
