base:
  '*':
    - debsecan
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
    - misc.jupiter
    - postfix.outbound
    - sabnzbd
    - sickbeard
    - smartmontools
  'neptune.djl.im':
    - misc.neptune
    - postfix.outbound
    - smartmontools
  'wilde.djl.im':
    - postfix.outbound
    - znc
