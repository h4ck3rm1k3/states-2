mysql-server:
  pkg.installed:
    - debconf: salt://mysql/mysql.deb.set

  service.running:
    - name: mysql
    - enable: True
    - watch:
      - pkg: mysqld

  mysql_user.present:
    - name: root
    - host: localhost
    - password_hash: "{{ pillar['mysql.pass'] }}"
    - connection_pass: ""
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

{% for db, args in pillar.get('mysql_databases', {}).items() %}
mysql_database_{{ db }}:
  mysql_database.present:
    - name: {{ db }}

{% for user in args['users'] %}
mysql_user_{{ user['name'] }}:
  mysql_user.present:
    - name: {{ user['name'] }}
    - password_hash: "{{ user['password_hash'] }}"

mysql_grant_{{ db }}_{{ user['name'] }}:
  mysql_grants.present:
    - database: "{{ db }}.*"
    - user: {{ user['name'] }}
    - grant: {{ user['grant'] }}
{% endfor %}
{% endfor %}