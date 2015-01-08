#
# kodi user and groups
#
kodi:
  user.present:
    - groups:
      - kodi
      - audio
      - video
      - plugdev
    - require:
      - group: kodi

  group.present:
    - groups:
      - kodi
      - audio
      - video
      - plugdev

  pkg.installed:
    - name: kodi

  pkgrepo.managed:
    - ppa: team-kodi/ppa
    - require_in:
      - pkg: kodi

#
# required packages
#
kodi_extra_packages:
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
/etc/init/kodi.conf:
  file.managed:
    - source: salt://kodi/upstart/kodi.conf

/etc/iptables.d/50-kodi.txt:
  file.managed:
    - source: salt://kodi/iptables/50-kodi.txt
    - template: jinja
    - require:
      - file: /etc/iptables.d

/etc/pm/sleep.d/10_kodi-update-library:
  file.managed:
    - source: salt://kodi/pm/10_kodi-update-library
    - mode: 755

/etc/udev/rules.d/90-enable-remote-wake.rules:
  file.managed:
    - source: salt://kodi/udev/90-enable-remote-wake.rules
    - user: root
    - group: root
    - mode: 644

/etc/rc_keymaps/rc6_mce:
  file.managed:
    - source: salt://kodi/rc_keymaps/rc6_mce
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/home/kodi/.kodi/userdata/Lircmap.xml:
  file.managed:
    - source: salt://kodi/kodi/Lircmap.xml
    - user: kodi
    - group: kodi
    - require:
      - user: kodi
      - pkg: kodi

/home/kodi/.kodi/userdata/advancedsettings.xml:
  file.managed:
    - source: salt://kodi/kodi/advancedsettings.xml
    - user: kodi
    - group: kodi
    - require:
      - pkg: kodi
