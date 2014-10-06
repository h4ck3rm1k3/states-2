{% set user = salt['defaults.get']('madsonic:user') %}
{% set port = salt['defaults.get']('madsonic:port') %}

/etc/default/madsonic:
  file.managed:
    - source: salt://madsonic/madsonic.default.jinja
    - template: jinja
    - context:
        user: {{ user }}
        port: {{ port }}

/etc/iptables.d/50-madsonic.txt:
  file.managed:
    - source: salt://madsonic/iptables/50-madsonic.txt
    - template: jinja
    - context:
        port: {{ port }}
    - require:
      - file: /etc/iptables.d

/usr/bin/madsonic-rescan:
  file.managed:
    - source: salt://madsonic/bin/madsonic-rescan
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

