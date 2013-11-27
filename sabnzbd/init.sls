sabnzb_dependencies:
  pkg.installed:
    - names:
      - python-cheetah
      - python-openssl
      - python-tvdb-api
      - python-yenc

/etc/default/sabnzbd:
  file.managed:
    - source: salt://sabnzbd/sabnzbd.conf.jinja
    - template: jinja

/etc/init.d/sabnzbd:
  file.managed:
    - source: salt://sabnzbd/sabnzbd.init
    - mode: 755

/etc/iptables.d/50-sabnzbd.txt:
  file.managed:
    - source: salt://sabnzbd/iptables/50-sabnzbd.txt
    - template: jinja
    - context:
      sabnzbd_port: {{ pillar.get('sabnzbd_port', '7777') }}
    - require:
        - file: /etc/iptables.d

/etc/sabnzbd:
  file.directory:
    - mode: 775
    - user: root
    - group: wheel

/etc/sabnzbd/scripts.conf:
  file.managed:
    - source: salt://sabnzbd/scripts.conf
    - template: jinja
    - require:
        - file: /etc/sabnzbd

/etc/sabnzbd/scripts:
  file.recurse:
    - source: salt://sabnzbd/scripts
    - user: root
    - group: wheel
    - file_mode: 755
    - dir_mode: 775
    - require:
        - file: /etc/sabnzbd
