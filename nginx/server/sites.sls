{%- from "nginx/map.jinja" import server with context %}

{%- set ssl_certificates = {} %}

{%- for site_name, site in server.get('site', {}).iteritems() %}
{%- if site.enabled %}

{%- if site.get('ssl', {'enabled': False}).enabled and site.host.name not in ssl_certificates.keys() %}
{%- set _dummy = ssl_certificates.update({site.host.name: []}) %}

{%- set ca_file=site.ssl.get('ca_file', '') %}
{%- set key_file=site.ssl.get('key_file', '/etc/ssl/private/{0}.key'.format(site.host.name)) %}
{%- set cert_file=site.ssl.get('cert_file', '/etc/ssl/certs/{0}.crt'.format(site.host.name)) %}
{%- set chain_file=site.ssl.get('chain_file', '/etc/ssl/certs/{0}-with-chain.crt'.format(site.host.name)) %}

{%- if site.ssl.engine is not defined %}

{%- if site.ssl.key is defined %}

{{ site.host.name }}_public_cert:
  file.managed:
  - name: {{ cert_file }}
  {%- if site.ssl.cert is defined %}
  - contents_pillar: nginx:server:site:{{ site_name }}:ssl:cert
  {%- else %}
  - source: salt://pki/{{ site.ssl.authority }}/certs/{{ site.host.name }}.cert.pem
  {%- endif %}
  - require:
    - pkg: nginx_packages
  - watch_in:
    - service: nginx_service
    - cmd: nginx_init_{{ site.host.name }}_tls

{{ site.host.name }}_private_key:
  file.managed:
  - name: {{ key_file }}
  {%- if site.ssl.key is defined %}
  - contents_pillar: nginx:server:site:{{ site_name }}:ssl:key
  {%- else %}
  - source: salt://pki/{{ site.ssl.authority }}/certs/{{ site.host.name }}.key.pem
  {%- endif %}
  - mode: 400
  - require:
    - pkg: nginx_packages
    - file: /etc/ssl/private
  - watch_in:
    - cmd: nginx_init_{{ site.host.name }}_tls

{%- if site.ssl.chain is defined or site.ssl.authority is defined %}
{%- set ca_file=site.ssl.get('ca_file', '/etc/ssl/certs/{0}-ca-chain.crt'.format(site.host.name)) %}

{{ site.host.name }}_ca_chain:
  file.managed:
  - name: {{ ca_file }}
  {%- if site.ssl.chain is defined %}
  - contents_pillar: nginx:server:site:{{ site_name }}:ssl:chain
  {%- else %}
  - source: salt://pki/{{ site.ssl.authority }}/{{ site.ssl.authority }}-chain.cert.pem
  {%- endif %}
  - require:
    - pkg: nginx_packages
  - watch_in:
    - cmd: nginx_init_{{ site.host.name }}_tls

{% endif %}

{% endif %}

{% else %}
{# site.ssl engine is defined #}

{%- if site.ssl.authority is defined %}
{%- set ca_file=site.ssl.get('ca_file', '/etc/ssl/certs/ca-{0}.crt'.format(site.ssl.authority)) %}
{% endif %}

{% endif %}

nginx_init_{{ site.host.name }}_tls:
  cmd.run:
  - name: "cat {{ cert_file }} {{ ca_file }} > {{ chain_file }}"
  - creates: {{ chain_file }}
  - watch_in:
    - service: nginx_service

{% endif %}


sites-available-{{ site_name }}:
  file.managed:
  - name: {{ server.vhost_dir }}/{{ site.type }}_{{ site.name }}.conf
  {%- if site.type == 'nginx_proxy' %}
  - source: salt://nginx/files/proxy.conf
  {%- elif site.type == 'nginx_redirect' %}
  - source: salt://nginx/files/redirect.conf
  {%- elif site.type == 'nginx_static' %}
  - source: salt://nginx/files/static.conf
  {%- elif site.type == 'nginx_stats' %}
  - source: salt://nginx/files/stats.conf
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



{%- if grains.os_family == 'Debian' %}
sites-enabled-{{ site_name }}:
  file.symlink:
  - name: /etc/nginx/sites-enabled/{{ site.type }}_{{ site.name }}.conf
  - target: {{ server.vhost_dir }}/{{ site.type }}_{{ site.name }}.conf
{%- endif %}
{%- else %}

{{ server.vhost_dir }}/{{ site.type }}_{{ site.name }}.conf:
  file.absent

{%- if grains.os_family == 'Debian' %}
/etc/nginx/sites-enabled/{{ site.type }}_{{ site.name }}.conf:
  file.absent
{%- endif %}

{%- endif %}
{%- endfor %}
