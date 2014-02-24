openssh-server:
  pkg:
    - installed

ssh:
  service.running:
    - enable: True
    - watch:
        - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config.jinja
    - template: jinja

/etc/monit/conf.d/ssh:
  file.managed:
    - source: salt://ssh/monit/ssh
    - require:
      - pkg: monit
