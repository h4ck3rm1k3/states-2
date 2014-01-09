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

/etc/asound.conf:
  file.managed:
    - source: salt://xbmc/asound.conf

/etc/init/ir-keytable.conf:
  file.managed:
    - source: salt://xbmc/ir-keytable.conf
    - mode: 755

/etc/iptables.d/50-xbmc.txt:
  file.managed:
    - source: salt://xbmc/iptables/50-xbmc.txt
    - template: jinja
    - require:
      - file: /etc/iptables.d

/etc/pm/sleep.d/10_xbmc-update-library:
  file.managed:
    - source: salt://xbmc/pm/10_xbmc-update-library
    - mode: 755

/etc/udev/rules.d/90-remote-wake.rules:
  file.managed:
    - source: salt://xbmc/udev/90-remote-wake.rules
    - user: root
    - group: root
    - mode: 644