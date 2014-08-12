#
# xbmc user and groups
#
xbmc:
  user.present:
    - groups:
      - xbmc
      - audio
      - video
      - plugdev
    - require:
      - group: xbmc

  group.present:
    - groups:
      - xbmc
      - audio
      - video
      - plugdev

  pkg.installed:
    - name: xbmc

  pkgrepo.managed:
    - ppa: team-xbmc/ppa
    - require_in:
      - pkg: xbmc

#
# required packages
#
xbmc_extra_packages:
  pkg.installed:
    - pkgs:
      - acpi-support
      - alsa-base
      - alsa-utils
      - consolekit
      - i965-va-driver
      - linux-sound-base
      - pm-utils
      - policykit-1
      - udisks
      - upower
      - xinit

#
# config files
#
/etc/init/xbmc.conf:
  file.managed:
    - source: salt://xbmc/upstart/xbmc.conf

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

/etc/udev/rules.d/90-enable-remote-wake.rules:
  file.managed:
    - source: salt://xbmc/udev/90-enable-remote-wake.rules
    - user: root
    - group: root
    - mode: 644

/etc/rc_keymaps/rc6_mce:
  file.managed:
    - source: salt://xbmc/rc_keymaps/rc6_mce
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/home/xbmc/.xbmc/userdata/Lircmap.xml:
  file.managed:
    - source: salt://xbmc/xbmc/Lircmap.xml
    - user: xbmc
    - group: xbmc
    - require:
      - user: xbmc
      - pkg: xbmc

/home/xbmc/.xbmc/userdata/advancedsettings.xml:
  file.managed:
    - source: salt://xbmc/xbmc/advancedsettings.xml
    - user: xbmc
    - group: xbmc
    - require:
      - pkg: xbmc
