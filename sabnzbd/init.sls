python-cheetah:
  pkg:
    - installed

python-openssl:
  pkg:
    - installed

python-yenc:
  pkg:
    - installed

/usr/bin/sabnzbd:
  file.managed:
    - source: salt://sabnzbd/bin/sabnzbd
    - mode: 755

/etc/iptables.d/50-sabnzbd.txt:
  file.managed:
    - source: salt://sabnzbd/iptables/50-sabnzbd.txt
    - template: jinja
    - context:
      sabnzbd_port: {{ pillar.get('sabnzbd_port', '7777') }}
    - require:
        - file: /etc/iptables.d