iptables:
  pkg.installed

/etc/iptables.d:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - require:
      - pkg: iptables

/etc/iptables.d/99-default-rules.txt:
  file.managed:
    - source: salt://iptables/rules/99-default-rules.txt
    - require:
      - file: /etc/iptables.d

/etc/iptables.d/50-custom-rules.txt:
  file.managed:
    - source: salt://iptables/rules/50-custom-rules.txt
    - template: jinja
    - context:
      accept_tcp_ports: {{ pillar.get('accept_tcp_ports', []) }}
      accept_udp_ports: {{ pillar.get('accept_udp_ports', []) }}
      accept_tcp_source: {{ pillar.get('accept_tcp_source', []) }}
      accept_udp_source: {{ pillar.get('accept_udp_source', []) }}
    - require:
      - file: /etc/iptables.d

/etc/network/if-pre-up.d/iptables:
  file.managed:
    - source: salt://iptables/etc/network/if-pre-up.d/iptables
    - mode: 700
    - require:
        - pkg: iptables

Restore iptables rules:
  cmd.wait:
    - name: /etc/network/if-pre-up.d/iptables
    - watch:
      - file: /etc/iptables.d/*
