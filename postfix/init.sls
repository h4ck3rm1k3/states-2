postfix:
  pkg:
    - installed

  service.running:
    - watch:
      - file: /etc/postfix/main.cf

/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/etc/postfix/main.cf.jinja
    - template: jinja
    - require:
      - pkg: postfix

/etc/mailname:
  file.managed:
    - source: salt://postfix/etc/postfix/mailname.jinja
    - template: jinja

{% if 'aliases' in pillar %}
{% for alias, target in pillar['aliases'].iteritems() %}
{{ alias }}:
  alias.present:
    - target: {{ target }}
{% endfor %}
{% endif %}