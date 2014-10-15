{% set user = salt['defaults.get']('subsonic:user') %}
{% set port = salt['defaults.get']('subsonic:port') %}

/etc/default/subsonic:
  file.managed:
    - source: salt://subsonic/subsonic.default.jinja
    - template: jinja
    - context:
        user: {{ user }}
        port: {{ port }}

/etc/iptables.d/50-subsonic.txt:
  file.managed:
    - source: salt://subsonic/iptables/50-subsonic.txt
    - template: jinja
    - context:
        port: {{ port }}
    - require:
      - file: /etc/iptables.d

/usr/bin/subsonic-rescan:
  file.managed:
    - source: salt://subsonic/bin/subsonic-rescan
    - mode: 755
    - user: root
    - group: root

{{ user }}:
  user.present:
    - home: /home/{{ user }}
    - password: '!'
    - shell: '/usr/sbin/nologin'
    - groups:
      - {{ user }}
    - require:
      - group: {{ user }}

  group:
    - present
