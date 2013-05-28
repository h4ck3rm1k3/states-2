{% for pkg in pillar.get('extra_packages', []) %}
{{ pkg }}:
  pkg.installed
{% endfor %}