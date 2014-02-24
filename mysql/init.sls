mysql-server:
  pkg.installed:
    - debconf: salt://mysql/mysql.deb.set

  service.running:
    - name: mysql
    - enable: True
    - watch:
      - pkg: mysql-server

  mysql_user.present:
    - name: root
    - host: localhost
    - password: "{{ pillar['mysql.pass'] }}"
    - connection_pass: "somepass"
    - watch:
      - pkg: mysql-server
      - service: mysql

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

{% for db, args in pillar.get('mysql.databases', {}).items() %}
mysql_database_{{ db }}:
  mysql_database.present:
    - name: {{ db }}

{% for user in args['users'] %}
mysql_user_{{ user['name'] }}:
  mysql_user.present:
    - name: {{ user['name'] }}
    - password_hash: "{{ user['password_hash'] }}"
    - connection_pass: "{{ pillar['mysql.pass'] }}"

mysql_grant_{{ db }}_{{ user['name'] }}:
  mysql_grants.present:
    - database: "{{ db }}.*"
    - user: {{ user['name'] }}
    - grant: {{ user['grant'] }}
{% endfor %}
{% endfor %}

/etc/monit/conf.d/mysql:
  file.managed:
    - source: salt://mysql/monit/mysql
    - require:
      - pkg: monit
