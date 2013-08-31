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
    - debsecan
    - logcheck
    - misc.jupiter
    - postfix.outbound
    - sabnzbd
    - sickbeard
    - smartmontools
  'neptune.djl.im':
    - misc.neptune
    - postfix.outbound
    - udev
    - xbmc
  'wilde.djl.im':
    - debsecan
    - logcheck
    - postfix.outbound
    - znc
