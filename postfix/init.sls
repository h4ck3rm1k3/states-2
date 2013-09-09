postfix:
  pkg:
    - installed

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

{% if 'aliases' in pillar %}
{% for name, target in pillar['aliases'].iteritems() %}
alias_{{ name }}:
  alias.present:
    - name: {{ name }}
    - target: {{ target }}
{% endfor %}
{% endif %}