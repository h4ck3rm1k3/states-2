{% for user, args in pillar['users'].iteritems() %}
# the user
{{ user }}:
  user.present:
    - home: /home/{{ user }}
    - shell: {{ args.get('shell', '/bin/bash') }}
    {% if not args.get('keep_password', True) %}
    - password: "!"
    {% endif %}
    - groups:
      - {{ user }}
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

# ssh keys
{% if 'ssh_auth' in args %}
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
    - source: salt://keys/{{ user }}
    - require:
      - file: /home/{{ user }}/.ssh
{% endif %}

# user's groups
{% for group in args['groups'] %}
{{ group }}:
  group:
    - present
{% endfor %}
{% endfor %}
