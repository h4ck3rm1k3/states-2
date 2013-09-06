avahi-daemon:
  pkg:
    - installed

  service:
    - running
    - enable: True

/etc/iptables.d/50-avahi-daemon.txt:
  file.managed:
    - source: salt://avahi/iptables/50-avahi-daemon.txt
    - require:
      - file: /etc/iptables.d

/etc/logcheck/ignore.d.server/local-avahi-daemon:
  file.managed:
    - source: salt://avahi/logcheck/local-avahi-daemon
    - user: logcheck
    - group: logcheck
    - require:
        - pkg: logcheck
