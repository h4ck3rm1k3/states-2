openvpn:
  pkg:
    - installed

  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - file: /etc/openvpn/server.conf

/etc/openvpn/server.conf:
  file.managed:
    - source: salt://openvpn/server.conf
    - require:
        - pkg: openvpn

/etc/iptables.d/50-openvpn.txt:
  file.managed:
    - source: salt://openvpn/iptables/50-openvpn.txt
    - require:
      - file: /etc/iptables.d

/etc/logcheck.d/ignore.d.server/local-openvpn-server:
  file.managed:
    - source: salt://openvpn/logcheck/local-openvpn-server
    - require:
        - pkg: logcheck

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
    - config: "/etc/sysctl.d/openvpn.conf"
