apache2:
  pkg:
    - installed

  service.running:
    - enable: True
    - require:
      - pkg: apache2
    - watch:
      - file: /etc/apache2/apache2.conf
      - file: /etc/apache2/conf.d/*
      - file: /etc/apache2/sites-available/*
      - file: /etc/apache2/sites-enabled/*

/etc/apache2/apache2.conf:
  file.managed:
    - source: salt://apache/apache2.conf.jinja
    - template: jinja
    - require:
      - pkg: apache2

/etc/apache2/conf.d:
  file.directory:
    - require:
      - pkg: apache2

/etc/apache2/conf.d/ports.conf:
  file.managed:
    - source: salt://apache/conf.d/ports.conf
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
      - file: /etc/iptables.d

/etc/logrotate.d/apache2:
  file.managed:
    - source: salt://apache/logrotate/apache2
    - require:
      - pkg: logrotate

{% for site, args in pillar.get('apache.sites', {}).items() %}
{% set fqdn = args.get('fqdn', site) %}
/var/log/apache2/{{ fqdn }}:
  file.directory:
    - require:
      - pkg: apache2

/var/www/{{ fqdn }}:
  file.directory:
    - user: {{ args.get('user', 'www-data') }}
    - group: {{ args.get('group', 'www-data') }}
    - require:
      - pkg: apache2

/etc/apache2/sites-available/{{ fqdn }}.conf:
  file.managed:
    - source: salt://apache/site.conf.jinja
    - template: jinja
    - context:
        fqdn: {{ fqdn }}
        args: {{ args }}
    - require:
      - file: /etc/apache2/sites-available

{% if args.get('enable', True) %}
/etc/apache2/sites-enabled/{{ fqdn }}.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/{{ fqdn }}.conf
    - require:
      - file: /etc/apache2/sites-enabled
{% else %}
/etc/apache2/sites-enabled/{{ fqdn }}.conf:
  file.absent:
    - require:
      - pkg: /etc/apache2/sites-enabled
{% endif %}

{% if args.get('default', False) %}
/etc/apache2/sites-enabled/000-default:
    file.symlink:
    - target: /etc/apache2/sites-available/{{ fqdn }}.conf
    - require:
      - file: /etc/apache2/sites-enabled
{% endif %}
{% endfor %}

{% for module in pillar.get('apache.modules', []) %}
a2enmod {{ module }}:
  cmd.run:
    - unless: test -f /etc/apache2/mods-enabled/{{ module }}.load
    - require:
      - pkg: apache2
{% endfor %}