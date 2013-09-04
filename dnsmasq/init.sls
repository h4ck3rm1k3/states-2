dnsmasq:
  pkg:
    - installed

  service:
    - running
    - enable: True
    - watch:
        - file: /etc/dnsmasq.conf

/etc/dnsmasq.conf:
  file.managed:
    - source: salt://dnsmasq/dnsmasq.conf

/etc/iptables.d/50-dnsmasq.txt:
  file.managed:
    - source: salt://dnsmasq/iptables/50-dnsmasq.txt