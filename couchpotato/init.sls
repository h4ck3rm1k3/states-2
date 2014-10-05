{% set user = salt['defaults.get']('couchpotato:user') %}
{% set home = salt['defaults.get']('couchpotato:home') %}
{% set data = salt['defaults.get']('couchpotato:data') %}
{% set pidfile = salt['defaults.get']('couchpotato:pidfile') %}
{% set port = salt['defaults.get']('couchpotato:port') %}
{% set repo = salt['defaults.get']('couchpotato:repo') %}

/etc/init.d/couchpotato:
  file.managed:
    - source: salt://couchpotato/couchpotato.init
    - mode: 755

/etc/default/couchpotato:
  file.managed:
    - source: salt://couchpotato/couchpotato.default.jinja
    - template: jinja
    - context:
        user: {{ user }}
        home: {{ home }}
        data: {{ data }}
        pidfile: {{ pidfile }}

/etc/iptables.d/50-couchpotato.txt:
  file.managed:
    - source: salt://couchpotato/iptables/50-couchpotato.txt
    - template: jinja
    - context:
        port: {{ port }}
    - require:
      - file: /etc/iptables.d

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

{{ home }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: {{ user }}
      - group: {{ user }}

{{ data }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: {{ user }}
      - group: {{ user }}

git clone {{ repo }} {{ home }}:
  cmd.run:
    - user: {{ user }}
    - unless: test -d {{ home }}/.git
    - require:
      - file: {{ home }}
      - user: {{ user }}