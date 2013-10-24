{% for user, args in pillar['users'].iteritems() %}
# the user
{{ user }}:
  user.present:
    - home: /home/{{ user }}
    - shell: {{ args.get('shell', '/bin/bash') }}
    - password: "!"
    - groups:
      - {{ user }}
    {% for group in args.get('groups', []) %}
      - {{ group }}
    {% endfor %}
    - require:
    {% for group in args.get('groups', []) %}
      - group: {{ group }}
    {% endfor %}

  group:
    - present

  {% if 'alias' in args %}
  alias.present:
    - target: {{ args['alias'] }}
  {% endif %}

# ssh keys
/home/{{ user }}/.ssh:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - require:
      - user: {{ user }}

/home/{{ user }}/.ssh/authorized_keys:
  file.managed:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - source: salt://keys/{{ user }}.pub
    - require:
      - file: /home/{{ user }}/.ssh

# user's groups
{% for group in args.get('groups', []) %}
{{ group }}:
  group:
    - present
{% endfor %}
{% endfor %}
