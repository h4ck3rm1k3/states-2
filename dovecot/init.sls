dovecot:
  pkg.installed:
    - name: dovecot-core

  service.running:
    - enable: True
    - watch:
      - file: /etc/dovecot/conf.d/*

/etc/dovecot/conf.d/10-auth.conf:
  file.managed:
    - source: salt://dovecot/10-auth.conf
    - require:
      - pkg: dovecot

/etc/dovecot/conf.d/10-master.conf:
  file.managed:
    - source: salt://dovecot/10-master.conf
    - require:
      - pkg: dovecot

/etc/dovecot/passwd:
  file.managed:
    - source: salt://dovecot/passwd.jinja:
    - template: jinja
    - require:
      - pkg: dovecot
