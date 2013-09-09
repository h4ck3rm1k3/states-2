/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/main.outbound.cf.jinja
    - template: jinja
    - require:
      - pkg: postfix
