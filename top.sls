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
    - debsecan
    - fstab
    - misc.helium
    - sabnzbd
    - sickbeard
    - smartmontools
  'iron.djl.im':
    - debsecan
    - dnsmasq
    - openvpn
    - znc
  'neon.djl.im':
    - fstab
    - misc.neon
    - udev
    - xbmc
