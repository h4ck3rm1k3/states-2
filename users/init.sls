{% for user, args in pillar.get('users', {}).iteritems() %}
# the user
{{ user }}:
  user.present:
    - home: /home/{{ user }}
    - shell: {{ args.get('shell', '/bin/bash') }}
    - password: {{ args.get('password', '!') }}
    - groups:
      - {{ user }}
    {% for group in args.get('groups', []) %}
      - {{ group }}
    {% endfor %}
    - require:
      - group: {{ user }}
    {% for group in args.get('groups', []) %}
      - group: {{ group }}
    {% endfor %}

  group:
    - present

  {% if 'alias' in args %}
  alias.present:
    - target: {{ args['alias'] }}
  {% endif %}

  {% if 'ssh_auth' in args %}
  ssh_auth.present:
    - user: {{ user }}
    {% if 'source' in args['ssh_auth'] %}
    - source: {{ args['ssh_auth']['source'] }}
    {% else %}
    - name: {{ args['ssh_auth']['name'] }}
    - enc: {{ args['ssh_auth']['enc'] }}
    {% endif %}
    - require:
      - user: {{ user }}
  {% endif %}

# user's groups
{% for group in args.get('groups', []) %}
{{ group }}:
  group:
    - present
{% endfor %}
{% endfor %}
