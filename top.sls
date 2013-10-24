base:
  '*':
    - iptables
    - logcheck
    - motd
    - ntp
    - packages
    - postfix
    - salt
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
    - openvpn
    - znc
  'neon.djl.im':
    - apt
    - fstab
    - xbmc
