/usr/bin/earl:
  file.managed:
    - source: https://raw.github.com/djl/earl/master/bin/earl
    - source_hash: sha1=7faee8461df5421ecb3936959fe0b88a2cc8482e
    - mode: 755

/usr/bin/smash:
  file.managed:
    - source: https://raw.github.com/djl/smash/master/bin/smash
    - source_hash: sha1=b12458e762dc974f0a58d7a183729a1cb4a09106
    - mode: 755
