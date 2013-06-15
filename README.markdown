Personal [Salt](http://saltstack.org/) states. Debian scented.


Example Pillar data
-------------------

### iptables

    # Ports accepting TCP connections
    accept_tcp_ports:
      - 22
      - 80
      - 443

    # Ports accepting UDP connections
    accept_udp_ports:
      - 53


### misc packages

    # Some extra packages
    extra_packages:
      - unrar


### ssh

    # Users allow to log in via ssh
    allowed_users:
       - djl


### timezone

    # What time is it?
    timezone: "Europe/London"


### users

    # Required users
    users:
      djl:
        alias: me@mydomain.com
        keep_password: true
        groups:
          - firstgroup
          - secondgroup
        ssh_auth:
          key: big_long_key_here
          comment: some_comment
