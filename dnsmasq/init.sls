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