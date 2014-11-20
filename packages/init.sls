{% set installed = salt['pillar.get']('packages:installed', []) %}
{% set purged = salt['pillar.get']('packages:purged', []) %}

{% if installed %}
packages_installed:
  pkg.installed:
    - pkgs:
{%- for pkg in installed %}
      - {{ pkg }}
{%- endfor %}
{% endif %}

{% if purged %}
packages_purged:
  pkg.purged:
    - pkgs:
{%- for pkg in purged %}
      - {{ pkg }}
{%- endfor %}
{% endif %}