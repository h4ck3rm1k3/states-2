base:
  '*':
    - development
    - extra_packages
    - iptables
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
    - logcheck
    - misc.jupiter
    - postfix.outbound
    - sabnzbd
    - sickbeard
    - smartmontools
  'neptune.djl.im':
    - avahi
    - misc.neptune
    - postfix.outbound
    - udev
    - xbmc
  'wilde.djl.im':
    - debsecan
    - dnsmasq
    - logcheck
    - openvpn
    - postfix.outbound
    - znc
