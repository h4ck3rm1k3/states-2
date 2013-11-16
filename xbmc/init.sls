xbmc:
  pkg:
    - installed

  pkgrepo.managed:
    - ppa: nathan-renniewaldock/xbmc-stable
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

/etc/asound.conf:
  file.managed:
    - source: salt://xbmc/asound.conf

/etc/init/ir-keytable.conf:
  file.managed:
    - source: salt://xbmc/ir-keytable.conf
    - mode: 755

/etc/udev/rules.d/90-remote-wake.rules:
  file.managed:
    - source: salt://xbmc/90-remote-wake.rules
    - user: root
    - group: root
    - mode: 644