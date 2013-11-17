php_packages:
  pkg.installed:
    - pkgs:
        - php5
        - php5-cli
        - php5-common
        - php5-curl

/etc/php5/apache2/conf.d/10-custom.ini:
  file.managed:
    - source: salt://php/10-custom.ini