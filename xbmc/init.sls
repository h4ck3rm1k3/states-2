xbmc:
  pkg:
    - installed

  pkgrepo.managed:
    - ppa: team-xbmc/ppa
    - require_in:
      - pkg: xbmc

/home/xbmc/.xbmc/userdata/Lircmap.xml:
  file.managed:
    - user: xbmc
    - group: xbmc
    - require:
      - pkg: xbmc

/home/xbmc/.xbmc/userdata/advancedsettings.xml:
  file.managed:
    - user: xbmc
    - group: xbmc
    - require:
      - pkg: xbmc

/etc/init/ir-keytable.conf:
  file.managed:
    - source: salt://xbmc/ir-keytable.conf
    - mode: 755