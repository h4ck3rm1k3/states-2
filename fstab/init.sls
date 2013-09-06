{% if 'mounts' in pillar.keys() %}
{% for mount, options in pillar['mounts'].items() %}
{{ mount }}:
  mount.mounted:
    - name: {{ mount }}
    - device: {{ options.device }}
    - fstype: {{ options.fstype }}
    - mkmnt: {{ options.get('mkmnt', False) }}
    - opts: {{ options.get('opts', '') }}
{% endfor %}
{% endif %}