base:
  '*':
    - iptables
    - logcheck
    - logrotate
    - monit
    - motd
    - ntp
    - packages
    - pam
    - postfix
    - salt.common
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
    - php
    - salt.master
    - znc
  'neon.djl.io':
    - fstab
    - xbmc
