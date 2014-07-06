postfix:
  pkg:
    - installed
  {% if pillar.get('postfix.enable_smtp_relay') %}
  require:
    - pkg: dovecot-core
  {% endif %}

  service.running:
    - enable: True
    - watch:
      - file: /etc/postfix/main.cf


/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/main.cf.jinja
    - template: jinja
    - require:
      - pkg: postfix

/etc/postfix/master.cf:
  file.managed:
    - source: salt://postfix/master.cf.jinja
    - template: jinja
    - require:
      - pkg: postfix

{% if pillar.get('postfix.enable_smtp_relay') %}
/etc/postfix/header_checks:
  file.managed:
    - source: salt://postfix/header_checks
    - template: jinja
    - require:
      - pkg: postfix

  cmd.wait:
    - name: "postmap /etc/postfix/header_checks"
    - watch:
      - file: /etc/postfix/header_checks
    - require:
      - pkg: postfix

/etc/postfix/sender_relay:
  file.managed:
    - source: salt://postfix/sender_relay.jinja
    - template: jinja
    - require:
      - pkg: postfix

  cmd.wait:
    - name: "postmap /etc/postfix/sender_relay"
    - watch:
      - file: /etc/postfix/header_checks
    - require:
      - pkg: postfix

/etc/iptables.d/50-postfix.txt:
  file.managed:
    - source: salt://postfix/iptables/50-postfix.txt
    - require:
      - file: /etc/iptables.d
{% endif %}

{% if 'aliases' in pillar %}
{% for name, target in pillar['aliases'].iteritems() %}
alias_{{ name }}:
  alias.present:
    - name: {{ name }}
    - target: {{ target }}
{% endfor %}
{% endif %}