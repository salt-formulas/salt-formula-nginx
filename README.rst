
=====
Nginx
=====

Nginx is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage.

Sample pillars
==============

Gitlab server setup

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        bind:
          address: '0.0.0.0'
          ports:
          - 80
        site:
          gitlab_domain:
            enabled: true
            type: gitlab
            name: domain
            ssl:
              enabled: true
              key: |
                -----BEGIN RSA PRIVATE KEY-----
                ...
              cert: |
                xyz
              chain: |
                my_chain..
            host:
              name: gitlab.domain.com
              port: 80

Simple static HTTP site

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_static_site01:
            enabled: true
            type: static
            name: site01
            host:
              name: gitlab.domain.com
              port: 80

Simple HTTP proxy

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site01:
            enabled: true
            type: proxy
            name: site01
            proxy:
              host: local.domain.com
              port: 80
              protocol: http
            host:
              name: gitlab.domain.com
              port: 80

Simple Websocket proxy

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site02:
            enabled: true
            type: proxy
            name: site02
            proxy:
              websocket: true
              host: local.domain.com
              port: 80
              protocol: http
            host:
              name: gitlab.domain.com
              port: 80

Content filtering proxy

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          nginx_proxy_site03:
            enabled: true
            type: proxy
            name: site03
            proxy:
              host: local.domain.com
              port: 80
              protocol: http
              filter:
                search: https://www.domain.com
                replace: http://10.10.10.10
            host:
              name: gitlab.domain.com
              port: 80

Gitlab server with user for basic auth

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        user:
          username1:
            enabled: true
            password: magicunicorn
            htpasswd: htpasswd-site1
          username2:
            enabled: true
            password: magicunicorn

Proxy buffering

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        bind:
          address: '0.0.0.0'
          ports:
          - 80
        site:
          gitlab_proxy:
            enabled: true
            type: proxy
            proxy:
              buffer:
                number: 8
                size: 16
            host:
              name: gitlab.domain.com
              port: 80

Let's Encrypt

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        bind:
          address: '0.0.0.0'
          ports:
          - 443
        site:
          gitlab_domain:
            enabled: true
            type: gitlab
            name: domain
            ssl:
              enabled: true
              engine: letsencrypt
            host:
              name: gitlab.domain.com
              port: 443

Nginx stats server (required by collectd nginx plugin)

.. code-block::

    nginx:
      server:
        enabled: true
        site:
          nginx_stats_server:
            enabled: true
            type: nginx_stats
            name: server
            host:
              name: 127.0.0.1
              port: 8888

Read more
=========

* http://wiki.nginx.org/Main
* https://wiki.mozilla.org/Security/Server_Side_TLS#Modern_compatibility
* http://nginx.com/resources/admin-guide/reverse-proxy/
* https://mozilla.github.io/server-side-tls/ssl-config-generator/
