{%- from "nginx/map.jinja" import server with context %}

{%- for user_name, user in server.get('user', {}).iteritems() %}
{%- if user.enabled %}

nginx_setup_user_{{ user_name }}:
  webutil.user_exists:
  - name: {{ user_name }}
  {%- if user.htpasswd is defined %}
  - htpasswd_file: /etc/nginx/{{ user.htpasswd }}
  {%- else %}
  - htpasswd_file: /etc/nginx/htpasswd
  {%- endif %}
  - password: {{ user.password }}
  {%- if user.opts is defined %}
  - options: '{{ user.opts }}'
  {%- endif %}

{%- else %}

nginx_setup_user_{{ user_name }}_absent:
  module.run:
  - name: htpasswd.userdel
  - user: {{ user_name }}
  {%- if user.htpasswd is defined %}
  - pwfile: /etc/nginx/{{ user.htpasswd }}
  {%- else %}
  - pwfile: /etc/nginx/htpasswd
  {%- endif %}

{%- endif %}
{%- endfor %}
