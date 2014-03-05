{% if pillar.get('pam.notify_on_login', True) %}
libpam-modules:
  pkg.installed

/usr/bin/pam-notify-login:
  file.managed:
    - source: salt://pam/pam-notify-login
    - mode: 655

/etc/pam.d/sshd:
  file.append:
    - text:
      - session optional pam_exec.so /usr/bin/pam-notify-login
{% endif %}