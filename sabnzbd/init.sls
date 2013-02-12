python-cheetah:
  pkg:
    - installed

python-openssl:
  pkg:
    - installed

python-yenc:
  pkg:
    - installed

/usr/local/bin/sabnzbd:
  file.managed:
    - source: salt://sabnzbd/bin/sabnzbd
    - mode: 755
