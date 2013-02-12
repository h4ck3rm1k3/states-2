/etc/timezone:
  file.managed:
    - template: jinja
    - source: salt://timezones/etc/timezone.jinja
    - context:
        timezone: {{ pillar.get('timezone', 'Europe/London') }}

/etc/localtime:
  file.symlink:
    - target: /usr/share/zoneinfo/{{ pillar.get('timezone', 'Europe/London') }}
    - force: True
