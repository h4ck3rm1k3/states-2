{% set user = salt['pillar.get']('sabnzbd:user', 'sabnzbd') %}
{% set home = salt['pillar.get']('sabnzbd:home', '/usr/share/sabnzbd') %}
{% set data = salt['pillar.get']('sabnzbd:data', '/var/lib/sabnzbd') %}
{% set pidfile = salt['pillar.get']('sabnzbd:pidfile', '/var/run/sabnzbd/sabnzbd.pid') %}
{% set port = salt['pillar.get']('sabnzbd:port', '8080') %}

sabnzbdplus_dependencies:
  pkg.installed:
    - names:
      - python-cheetah
      - python-openssl
      - python-requests
      - python-tvdb-api
      - python-yenc
      - par2
      - unrar
      - unzip

/etc/init.d/sabnzbd:
  file.managed:
    - source: salt://sabnzbd/sabnzbd.init
    - mode: 755

/etc/default/sabnzbd:
  file.managed:
    - source: salt://sabnzbd/sabnzbd.default.jinja
    - template: jinja
    - context:
        user: {{ user }}
        home: {{ home }}
        data: {{ data }}
        pidfile: {{ pidfile }}

/etc/iptables.d/50-sabnzbd.txt:
  file.managed:
    - source: salt://sabnzbd/iptables/50-sabnzbd.txt
    - template: jinja
    - context:
        port: {{ port }}
    - require:
      - file: /etc/iptables.d

{{ home }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}

{{ data }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}

{{ data }}/scripts:
  file.recurse:
    - source: salt://sabnzbd/scripts
    - user: {{ user }}
    - group: {{ user }}
    - file_mode: 755
    - dir_mode: 755
    - require:
      - file: {{ data }}

{{ data }}/scripts.conf:
  file.managed:
    - source: salt://sabnzbd/scripts.conf
    - template: jinja
    - require:
      - file: {{ data }}