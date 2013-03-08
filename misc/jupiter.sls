/usr/local/bin/earl:
  file.managed:
    - source: https://raw.github.com/djl/earl/master/bin/earl
    - source_hash: sha1=7faee8461df5421ecb3936959fe0b88a2cc8482e
    - mode: 755

/usr/local/bin/julian:
  file.managed:
    - source: https://raw.github.com/djl/julian/master/bin/julian
    - source_hash: sha1=579ceae3f50e7180a242992679c7541ec123d719
    - mode: 755
