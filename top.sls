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
    - debsecan
    - fstab
    - sabnzbd
    - sickbeard
    - smartmontools
  'iron.djl.im':
    - apt
    - debsecan
    - dnsmasq
    - salt.master
    - openvpn
    - znc
  'neon.djl.im':
    - apt
    - fstab
    - xbmc
