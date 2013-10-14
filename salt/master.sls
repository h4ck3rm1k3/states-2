salt-master:
  pkg.installed

/etc/salt/master:
  file.managed:
    - source: salt://salt/master.conf
    - mode: 640
    - user: root
    - group: root
    - require:
        - pkg: salt-master

/etc/iptables.d/50-salt-master.txt:
  - source: salt://znc/iptables/50-salt-master.txt
  - template: jinja
  - require:
  - file: /etc/iptables.d
