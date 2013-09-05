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

/etc/iptables.d/50-xbmc.txt:
  file.managed:
    - source: salt://xbmc/iptables/50-xbmc.txt
    - require:
      - file: /etc/iptables.d