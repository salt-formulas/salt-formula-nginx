{%- from "nginx/map.jinja" import server with context %}

{%- for site_name, site in server.get('site', {}).iteritems() %}
{%- if site.enabled %}

{% if site.ssl is defined and site.ssl.enabled %}

{%- if site.ssl.engine is not defined %}

{{ site.host.name }}_public_cert_{{ loop.index }}:
  file.managed:
  - name: /etc/ssl/certs/{{ site.host.name }}.crt
  {%- if site.ssl.cert is defined %}
  - contents_pillar: nginx:server:site:{{ site_name }}:ssl:cert
  {%- else %}
  - source: salt://pki/{{ site.ssl.authority }}/certs/{{ site.host.name }}.cert.pem
  {%- endif %}
  - require:
    - pkg: nginx_packages
  - watch_in:
    - service: nginx_service

{{ site.host.name }}_private_key_{{ loop.index }}:
  file.managed:
  - name: /etc/ssl/private/{{ site.host.name }}.key
  {%- if site.ssl.key is defined %}
  - contents_pillar: nginx:server:site:{{ site_name }}:ssl:key
  {%- else %}
  - source: salt://pki/{{ site.ssl.authority }}/certs/{{ site.host.name }}.key.pem
  {%- endif %}
  - mode: 400
  - require:
    - pkg: nginx_packages

{{ site.host.name }}_ca_chain_{{ loop.index }}:
  file.managed:
  - name: /etc/ssl/certs/{{ site.host.name }}-ca-chain.crt
  {%- if site.ssl.chain is defined %}
  - contents_pillar: nginx:server:site:{{ site_name }}:ssl:chain
  {%- else %}
  - source: salt://pki/{{ site.ssl.authority }}/{{ site.ssl.authority }}-chain.cert.pem
  {%- endif %}
  - require:
    - pkg: nginx_packages

nginx_init_{{ site.host.name }}_tls_{{ loop.index }}:
  cmd.wait:
  - name: "cat /etc/ssl/certs/{{ site.host.name }}.crt /etc/ssl/certs/{{ site.host.name }}-ca-chain.crt > /etc/ssl/certs/{{ site.host.name }}-with-chain.crt"
  - watch:
    - file: /etc/ssl/certs/{{ site.host.name }}.crt
    - file: /etc/ssl/certs/{{ site.host.name }}-ca-chain.crt
  - watch_in:
    - service: nginx_service

{%- endif %}

{% endif %}

sites-available-{{ site_name }}:
  file.managed:
  - name: /etc/nginx/sites-available/{{ site.type }}_{{ site.name }}.conf
  {%- if site.type == 'nginx_proxy' %}
  - source: salt://nginx/files/proxy.conf
  {%- elif site.type == 'nginx_redirect' %}
  - source: salt://nginx/files/redirect.conf
  {%- elif site.type == 'nginx_static' %}
  - source: salt://nginx/files/static.conf
  {%- else %}
  - source: salt://{{ site.type }}/files/nginx.conf
  {%- endif %}
  - template: jinja
  - require:
    - pkg: nginx_packages
  - watch_in:
    - service: nginx_service
  - defaults:
    site_name: "{{ site_name }}"

sites-enabled-{{ site_name }}:
  file.symlink:
  - name: /etc/nginx/sites-enabled/{{ site.type }}_{{ site.name }}.conf
  - target: /etc/nginx/sites-available/{{ site.type }}_{{ site.name }}.conf

{%- else %}

/etc/nginx/sites-available/{{ site.type }}_{{ site.name }}.conf:
  file.absent

/etc/nginx/sites-enabled/{{ site.type }}_{{ site.name }}.conf:
  file.absent

{%- endif %}
{%- endfor %}
