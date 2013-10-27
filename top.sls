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
    - apt
    - apticron
    - debsecan
    - dnsmasq
    - openvpn
    - salt.master
    - znc
  'neon.djl.im':
    - apt
    - fstab
    - xbmc
