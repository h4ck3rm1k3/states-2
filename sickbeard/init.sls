{% set user = salt['defaults.get']('sickbeard:user') %}
{% set home = salt['defaults.get']('sickbeard:home') %}
{% set data = salt['defaults.get']('sickbeard:data') %}
{% set pidfile = salt['defaults.get']('sickbeard:pidfile') %}
{% set port = salt['defaults.get']('sickbeard:port') %}
{% set repo = salt['defaults.get']('sickbeard:repo') %}

sickbeard_dependencies:
  pkg.installed:
    - names:
      - python-cheetah

/etc/init.d/sickbeard:
  file.managed:
    - source: salt://sickbeard/sickbeard.init
    - mode: 755

/etc/default/sickbeard:
  file.managed:
    - source: salt://sickbeard/sickbeard.default.jinja
    - template: jinja
    - context:
        user: {{ user }}
        home: {{ home }}
        data: {{ data }}
        pidfile: {{ pidfile }}

/etc/iptables.d/50-sickbeard.txt:
  file.managed:
    - source: salt://sickbeard/iptables/50-sickbeard.txt
    - template: jinja
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