
include:
{%- if pillar.nginx.server is defined %}
- nginx.server
{%- endif %}
