/usr/local/bin/earl:
  file.managed:
    - source: https://raw.github.com/djl/earl/master/bin/earl
    - source_hash: sha1=7faee8461df5421ecb3936959fe0b88a2cc8482e
    - mode: 755

/usr/local/bin/smash:
  file.managed:
    - source: https://raw.github.com/djl/smash/master/bin/smash
    - source_hash: sha1=2cd240883f8badf0689712e87d06aeb1e9faecb6
    - mode: 755
