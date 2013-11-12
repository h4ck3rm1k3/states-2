base:
  '*':
    - iptables
    - logcheck
    - motd
    - ntp
    - packages
    - postfix
    - salt.minion
    - ssh
    - sudo
    - timezones
    - users
  'helium.djl.im':
    - apt
    - apticron
    - debsecan
    - fstab
    - sabnzbd
    - sickbeard
    - smartmontools
  'iron.djl.im':
    - apache
    - apt
    - apticron
    - debsecan
    - dnsmasq
    - openvpn
    - php
    - owncloud
    - salt.master
    - znc
  'neon.djl.im':
    - apt
    - fstab
    - xbmc
