base:
  '*':
    - basepkgs
    - extra_packages
    - iptables
    - logcheck
    - motd
    - ntp
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
    - udev
    - xbmc
