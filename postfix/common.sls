postfix:
  pkg:
    - installed

  service.running:
    - watch:
      - file: /etc/postfix/main.cf

/etc/mailname:
  file.managed:
    - source: salt://postfix/etc/postfix/mailname.jinja
    - template: jinja

{% if 'aliases' in pillar %}
{% for name, target in pillar['aliases'].iteritems() %}
alias_{{ name }}:
  alias.present:
    - name: {{ name }}
    - target: {{ target }}
{% endfor %}
{% endif %}