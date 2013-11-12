apache2:
  pkg:
    - installed

  service.running:
    - enable: True
    - require:
      - pkg: apache2
    - watch:
      - file: /etc/apache2/apache2.conf
      - file: /etc/apache2/ports.conf
      - file: /etc/apache2/sites-enabled/*

/etc/apache2/apache2.conf:
  file.managed:
    - source: salt://apache/apache2.conf.j2
    - template: jinja
    - require:
      - pkg: apache2

/etc/apache2/ports.conf:
  file.managed:
    - source: salt://apache/ports.conf
    - require:
      - pkg: apache2

/etc/apache2/sites-available:
  file.directory:
    - require:
      - pkg: apache2

/etc/apache2/sites-enabled:
  file.directory:
    - require:
      - pkg: apache2

/etc/iptables.d/50-apache.txt:
  file.managed:
    - source: salt://apache/iptables/50-http.txt
    - require:
      - pkg: apache2

{% for site, args in pillar.get('apache_sites', {}).items() %}
/var/log/apache2/{{ args.fqdn }}:
  file.directory:
    - require:
      - pkg: apache2

/var/www/{{ args.fqdn }}:
  file.directory:
    - require:
      - pkg: apache2

/etc/apache2/sites-available/{{ args.fqdn }}.conf:
  file.managed:
    - source: salt://apache/site.conf.j2
    - template: jinja
    - context:
        site: {{ site }}
        args: {{ args }}
    - require:
      - file: /etc/apache2/sites-available

{% if args.get('enable', True) %}
/etc/apache2/sites-enabled/{{ args.fqdn }}.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/{{ args.fqdn }}.conf
    - require:
      - file: /etc/apache2/sites-enabled
{% else %}
/etc/apache2/sites-enabled/{{ args.fqdn }}.conf:
  file.absent:
    - require:
      - pkg: /etc/apache2/sites-enabled
{% endif %}
{% endfor %}
