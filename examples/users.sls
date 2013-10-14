# Required users
users:
  djl:
    alias: me@mydomain.com
    keep_password: true
    groups:
      - firstgroup
      - secondgroup
    ssh_auth:
      - source: salt://path/authorized_keys