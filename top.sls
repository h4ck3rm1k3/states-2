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
    - znc
  'neon.djl.im':
    - apt
    - fstab
    - xbmc
