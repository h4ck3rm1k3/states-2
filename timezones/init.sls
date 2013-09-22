/etc/timezone:
  file.managed:
    - contents: {{ pillar.get('timezone', 'Europe/London') }}

/etc/localtime:
  file.symlink:
    - target: /usr/share/zoneinfo/{{ pillar.get('timezone', 'Europe/London') }}
    - force: True
