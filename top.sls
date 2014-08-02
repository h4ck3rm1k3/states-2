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
    - sudo
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
    - fstab
    - madsonic
    - sabnzbd
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
    - xbmc
