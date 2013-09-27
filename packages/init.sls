basepkgs:
  pkg.installed:
    - pkgs:
        - git
        - vim

{%- if pillar.get('extra_packages', []) %}
extra_packages:
  pkg.installed:
    - names:
{%- for pkg in pillar.get('extra_packages', []) %}
      - {{ pkg }}
{%- endfor %}
{%- endif %}