iptables:
  pkg:
    - installed

/etc/iptables:
  file.directory:
    - user: root
    - group: root
    - mode: 700

/etc/iptables/rules:
  file.managed:
    - source: salt://iptables/etc/iptables/rules.jinja
    - template: jinja
    - context:
      accept_tcp_ports: {{ pillar.accept_tcp_ports or [] }}
      accept_udp_ports: {{ pillar.accept_udp_ports or [] }}
    - require:
      - pkg: iptables
      - file: /etc/iptables

iptables-restore < /etc/iptables/rules:
  cmd.wait:
    - watch:
      - file: /etc/iptables/rules