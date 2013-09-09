base:
  '*':
    - basepkgs
    - extra_packages
    - iptables
    - logcheck
    - motd
    - ntp
    - postfix.common
    - salt
    - ssh
    - sudo
    - timezones
    - users
  'helium.djl.im':
    - avahi
    - debsecan
    - fstab
    - misc.helium
    - postfix.outbound
    - sabnzbd
    - sickbeard
    - smartmontools
  'iron.djl.im':
    - debsecan
    - dnsmasq
    - openvpn
    - postfix.outbound
    - znc
  'neon.djl.im':
    - avahi
    - fstab
    - misc.neptune
    - postfix.outbound
    - udev
    - xbmc
