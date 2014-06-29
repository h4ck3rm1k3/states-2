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
    - timezones
    - users
  'os_family:Debian':
    - match: grain
    - apt
  'os:Debian':
    - match: grain
    - debsecan
    - apticron
  'fox.djl.im':
    - apache
    - mysql
    - php
    - salt.master
    - znc
  'helium.djl.im':
    - apache
    - fstab
    - madsonic
    - sabnzbd
    - sickbeard
    - smartmontools
    - unbound
  'neon.djl.im':
    - fstab
    - xbmc
