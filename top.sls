base:
  '*':
    - iptables
    - logcheck
    - logrotate
    - motd
    - ntp
    - packages
    - pam
    - postfix
    - salt.minion
    - ssh
    - timezone
    - users
  'os_family:Debian':
    - match: grain
    - apt
  'os:Debian':
    - match: grain
    - debsecan
    - apticron
  'helium.djl.io':
    - apache
    - couchpotato
    - fstab
    - sabnzbd
    - subsonic
    - sickbeard
    - smartmontools
    - unbound
  'iron.djl.io':
    - apache
    - mysql.server
    - mysql.client
    - mysql.database
    - mysql.user
    - php
    - salt.master
    - znc
  'neon.djl.io':
    - fstab
    - kodi
    - lirc
