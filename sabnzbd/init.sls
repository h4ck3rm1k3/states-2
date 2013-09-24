sabnzb_dependencies:
  pkg.installed:
    - names:
      - python-cheetah
      - python-openssl
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