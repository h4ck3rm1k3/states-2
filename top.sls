base:
  '*':
    - development
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
    - debsecan
    - misc.jupiter
    - postfix.outbound
    - sabnzbd
    - sickbeard
    - smartmontools
  'neptune.djl.im':
    - misc.neptune
    - postfix.outbound
    - smartmontools
    - xbmc
  'wilde.djl.im':
    - debsecan
    - postfix.outbound
    - znc
