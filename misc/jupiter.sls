/usr/local/bin/earl:
  file.managed:
    - source: https://raw.github.com/djl/earl/master/bin/earl
    - source_hash: sha1=78b90c219bd4f2ee44b84cfaef701ec683cf91e2
    - mode: 755

/usr/local/bin/julian:
  file.managed:
    - source: https://raw.github.com/djl/julian/master/bin/julian
    - source_hash: sha1=579ceae3f50e7180a242992679c7541ec123d719
    - mode: 755
