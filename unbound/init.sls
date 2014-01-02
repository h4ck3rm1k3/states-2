unbound:
  pkg:
    - installed

  service.running:
    - enable: True
    - require:
      - pkg: unbound
    - watch:
      - file: /etc/unbound/unbound.conf

/etc/unbound/unbound.conf:
  file.managed:
    - source: salt://unbound/unbound.conf
    - require:
      - pkg: unbound

/etc/unbound/root.key:
  file.managed:
    - source: salt://unbound/root.key
    - require:
      - pkg: unbound

/etc/unbound/root.hints:
  file.managed:
    - source: salt://unbound/root.hints
    - require:
      - pkg: unbound

/etc/iptables.d/50-unbound.txt:
  file.managed:
    - source: salt://unbound/iptables/50-unbound.txt
    - require:
      - file: /etc/iptables.d

