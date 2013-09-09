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
    - avahi
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
    - avahi
    - fstab
    - misc.neon
    - udev
    - xbmc
