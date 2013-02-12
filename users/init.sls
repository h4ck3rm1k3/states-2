{% for user, args in pillar['users'].iteritems() %}
# the user
{{ user }}:
  user.present:
    - home: /home/{{ user }}
    - shell: {{ args.get('shell', '/bin/bash') }}
    - password: "!"
    - groups:
    {% for group in args['groups'] %}
      - {{ group }}
    {% endfor %}
    - require:
    {% for group in args['groups'] %}
      - group: {{ group }}
    {% endfor %}

  group:
    - present

  {% if 'alias' in args.keys() %}
  alias.present:
    - target: {{ args['alias'] }}
  {% endif %}

# user's groups
{% for group in args['groups'] %}
{{ group }}:
  group:
    - present
{% endfor %}

# ssh key
{{ args['ssh_auth']['key'] }}:
  ssh_auth.present:
    - user: {{ user }}
    - comment: {{ args['ssh_auth']['comment'] }}
    - require:
      - user: {{ user }}

# home directory
/home/{{ user }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - require:
      - user: {{ user }}
      - group: {{ user }}
{% endfor %}
