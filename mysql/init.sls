python-mysqldb:
  pkg.installed

mysql-server:
  pkg.installed:
    - debconf: salt://mysql/mysql.deb.set
    - require:
      - pkg: python-mysqldb

  service.running:
    - name: mysql
    - enable: True
    - watch:
      - pkg: mysql-server

mysql-client:
  pkg:
    - installed

/etc/mysql/my.cnf:
  file.managed:
    - source: salt://mysql/my.cnf.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: mysql

mysql_root_user:
  mysql_user.present:
    - name: root
    - host: localhost
    - password: "{{ pillar['mysql.pass'] }}"
    - connection_pass: "somepass"
    - watch:
      - pkg: mysql-server
      - service: mysql
    - require:
      - pkg: mysql-server
      - pkg: mysql-client
      - service: mysql-server

{% for db, args in pillar.get('mysql.databases', {}).items() %}
mysql_database_{{ db }}:
  mysql_database.present:
    - name: {{ db }}
    - require:
      - pkg: mysql-server

{% for user in args['users'] %}
mysql_user_{{ user['name'] }}:
  mysql_user.present:
    - name: {{ user['name'] }}
    - password_hash: "{{ user['password_hash'] }}"
    - connection_pass: "{{ pillar['mysql.pass'] }}"
    - require:
      - mysql_database: {{ db }}

mysql_grant_{{ db }}_{{ user['name'] }}:
  mysql_grants.present:
    - database: "{{ db }}.*"
    - user: {{ user['name'] }}
    - grant: {{ user['grant'] }}
    - require:
      - mysql_database: {{ db }}
      - mysql_user: {{ user['name'] }}
{% endfor %}
{% endfor %}

/etc/monit/conf.d/mysql:
  file.managed:
    - source: salt://mysql/monit/mysql
    - require:
      - pkg: monit
