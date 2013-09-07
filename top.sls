base:
  '*':
    - basepkgs
    - extra_packages
    - iptables
    - logcheck
    - ntp
    - postfix.common
    - salt
    - ssh
    - sudo
    - timezones
    - users
  'jupiter.djl.im':
    - avahi
    - debsecan
    - fstab
    - misc.jupiter
    - postfix.outbound
    - sabnzbd
    - sickbeard
    - smartmontools
  'neptune.djl.im':
    - avahi
    - fstab
    - misc.neptune
    - postfix.outbound
    - udev
    - xbmc
  'wilde.djl.im':
    - debsecan
    - dnsmasq
    - openvpn
    - postfix.outbound
    - znc
