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
      accept_tcp_ports: {{ pillar.get('accept_tcp_ports', []) }}
      accept_udp_ports: {{ pillar.get('accept_udp_ports', []) }}
    - require:
      - pkg: iptables
      - file: /etc/iptables

iptables-restore < /etc/iptables/rules:
  cmd.wait:
    - watch:
      - file: /etc/iptables/rules