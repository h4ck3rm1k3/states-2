dnsmasq:
  pkg:
    - installed

  service:
    - running
    - enable: True
    - watch:
        - file: /etc/dnsmasq.conf