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
  'helium.djl.im':
    - apache
    - fstab
    - madsonic
    - sabnzbd
    - sickbeard
    - smartmontools
    - unbound
  'iron.djl.im':
    - apache
    - dnsmasq
    - mysql
    - openvpn
    - php
    - salt.master
    - znc
  'neon.djl.im':
    - fstab
    - xbmc
