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
