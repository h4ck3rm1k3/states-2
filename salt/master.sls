include:
  - salt.common

salt-master:
  pkg:
    - installed

  service.running:
    - enable: True
    - watch:
      - file: /etc/salt/master

/etc/salt/master:
  file.managed:
    - source: salt://salt/master.conf
    - mode: 640
    - user: root
    - group: root
    - require:
        - pkg: salt-master

/etc/iptables.d/50-salt-master.txt:
  file.managed:
    - source: salt://salt/iptables/50-salt-master.txt
    - template: jinja
    - require:
        - file: /etc/iptables.d

/usr/bin/ups:
  file.managed:
    - source: salt://salt/bin/ups
    - mode: 700
    - user: root
    - group: root
