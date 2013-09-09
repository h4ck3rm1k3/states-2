postfix:
  pkg:
    - installed

  service.running:
    - watch:
      - file: /etc/postfix/main.cf

{% if 'aliases' in pillar %}
{% for name, target in pillar['aliases'].iteritems() %}
alias_{{ name }}:
  alias.present:
    - name: {{ name }}
    - target: {{ target }}
{% endfor %}
{% endif %}