avahi-daemon:
  pkg.installed

/etc/iptables.d/50-avahi-daemon.txt:
  file.managed:
    - source: salt://avahi/iptables/50-avahi-daemon.txt
    - require:
      - file: /etc/iptables.d