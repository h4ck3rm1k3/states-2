sabnzbdplus:
  pkgrepo.managed:
    - name: deb http://ftp.uk.debian.org/debian/ testing contrib
    - file: /etc/apt/sources.list.d/testing.list
    - require_in:
      - pkg: sabnzbdplus
    - require:
      - pkg: sabnzbdplus_dependencies

  pkg.latest:
    - fromrepo: sabnzbdplus
    - require:
      - file: /etc/default/sabnzbdplus

  service.running:
    - enable: True
    - require:
      - pkg: sabnzbdplus
    - watch:
      - file: /etc/default/sabnzbdplus

sabnzbdplus_dependencies:
  pkg.installed:
    - names:
      - python-cheetah
      - python-openssl
      - python-requests
      - python-tvdb-api
      - python-yenc

/etc/default/sabnzbdplus:
  file.managed:
    - source: salt://sabnzbd/sabnzbdplus.default.jinja
    - template: jinja

/etc/iptables.d/50-sabnzbd.txt:
  file.managed:
    - source: salt://sabnzbd/iptables/50-sabnzbd.txt
    - template: jinja
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
