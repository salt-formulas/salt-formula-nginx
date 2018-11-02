
=============
Usage
=============

Nginx is an open source reverse proxy server for HTTP, HTTPS,
SMTP, POP3, and IMAP protocols, as well as a load balancer,
HTTP cache, and a web server (origin server). The nginx project
started with a strong focus on high concurrency, high performance
and low memory usage.

Sample Pillars
==============

Gitlab server setup:

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

Simple static HTTP site:

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_static_site01:
            enabled: true
            type: nginx_static
            name: site01
            host:
              name: gitlab.domain.com
              port: 80

Simple load balancer:

.. code-block:: yaml

    nginx:
      server:
        upstream:
          horizon-upstream:
            backend1:
              address: 10.10.10.113
              port: 8078
              opts: weight=3
            backend2:
              address: 10.10.10.114
        site:
          nginx_proxy_openstack_web:
            enabled: true
            type: nginx_proxy
            name: openstack_web
            proxy:
              upstream_proxy_pass: http://horizon-upstream
            host:
              name: 192.168.0.1
              port: 31337

Static site with access policy:

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_static_site01:
            enabled: true
            type: nginx_static
            name: site01
            access_policy:
              allow:
              - 192.168.1.1/24
              - 127.0.0.1
              deny:
              - 192.168.1.2
              - all
            host:
              name: gitlab.domain.com
              port: 80

Simple TCP/UDP proxy:

.. code-block:: yaml

    nginx:
      server:
        stream:
          rabbitmq:
            host:
              port: 5672
            backend:
              server1:
                address: 10.10.10.113
                port: 5672
                least_conn: true
                hash: "$remote_addr consistent"
          unbound:
            host:
              bind: 127.0.0.1
              port: 53
              protocol: udp
            backend:
              server1:
                address: 10.10.10.113
                port: 5353

Simple HTTP proxy:

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site01:
            enabled: true
            type: nginx_proxy
            name: site01
            proxy:
              host: local.domain.com
              port: 80
              protocol: http
            host:
              name: gitlab.domain.com
              port: 80

Simple HTTP proxy with multiple locations:

.. note:: If proxy part is defined and location is missing ``/``,
          the proxy part is used. If the ``/`` location is defined,
          it overrides the proxy part.

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site01:
            enabled: true
            type: nginx_proxy
            name: site01
            proxy:
              host: local.domain.com
              port: 80
              protocol: http
            location:
              /internal/:
                host: 172.120.10.200
                port: 80
                protocol: http
              /doc/:
                host: 172.10.10.200
                port: 80
                protocol: http
            host:
              name: gitlab.domain.com
              port: 80

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site01:
            enabled: true
            type: nginx_proxy
            name: site01
            location:
              /:
                host: 172.120.10.200
                port: 80
                protocol: http
              /doc/:
                host: 172.10.10.200
                port: 80
                protocol: http
            host:
              name: gitlab.domain.com
              port: 80

Simple Websocket proxy:

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site02:
            enabled: true
            type: nginx_proxy
            name: site02
            proxy:
              websocket: true
              host: local.domain.com
              port: 80
              protocol: http
            host:
              name: gitlab.domain.com
              port: 80

Content filtering proxy:

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          nginx_proxy_site03:
            enabled: true
            type: nginx_proxy
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

Proxy with access policy:

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site01:
            enabled: true
            type: nginx_proxy
            name: site01
            access_policy:
              allow:
              - 192.168.1.1/24
              - 127.0.0.1
              deny:
              - 192.168.1.2
              - all
            proxy:
              host: local.domain.com
              port: 80
              protocol: http
            host:
              name: gitlab.domain.com
              port: 80

Proxy with rate limiting scheme:

.. code-block:: yaml

    _dollar: '$'
    nginx:
      server:
        site:
          nginx_proxy_site01:
            enabled: true
            type: nginx_proxy
            name: site01
            proxy:
              host: local.domain.com
              port: 80
              protocol: http
            host:
              name: gitlab.domain.com
              port: 80
            limit:
              enabled: True
              ip_whitelist:
              - 127.0.0.1
              burst: 600
              rate: 10r/s
              nodelay: True
              subfilters:
                heavy_url:
                  input: ${_dollar}{binary_remote_addr}${_dollar}{request_uri}
                  mode: blacklist
                  items:
                  - "~.*servers/detail[?]name=.*&status=ACTIVE"
                  rate: 2r/m
                  burst: 2
                  nodelay: True

Gitlab server with user for basic auth:

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

Proxy buffering:

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
            type: nginx_proxy
            proxy:
              request_buffer: false
              buffer:
                number: 8
                size: 16
            host:
              name: gitlab.domain.com
              port: 80

Let's Encrypt:

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

SSL using already deployed key and cert file.

.. note:: The cert file should already contain CA cert and
          complete chain.

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          mysite:
            ssl:
              enabled: true
              key_file: /etc/ssl/private/mykey.key
              cert_file: /etc/ssl/cert/mycert.crt

Advanced SSL configuration, more information about SSL option
may be found at http://nginx.org/en/docs/http/ngx_http_ssl_module.html

.. note:: Prior to nginx 1.11.0, only one type of ecdh curve
          can be applied in ``ssl_ecdh_curve directive``.

          if mode = ``secure`` or mode = ``normal`` and ``ciphers``
          or ``protocols`` are set, they should have type ``string``.
          If mode = ``manual``, their type should be ``dict``
          as shown below.

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          mysite:
            ssl:
              enabled: true
              mode: 'manual'
              key_file:  /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}.key
              cert_file: /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}.crt
              chain_file: /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}-with-chain.crt
              protocols:
                TLS1:
                  name: 'TLSv1'
                  enabled: True
                TLS1_1:
                  name: 'TLSv1.1'
                  enabled: True
                TLS1_2:
                  name: 'TLSv1.2'
                  enabled: False
              ciphers:
                ECDHE_RSA_AES256_GCM_SHA384:
                  name: 'ECDHE-RSA-AES256-GCM-SHA384'
                  enabled: True
                ECDHE_ECDSA_AES256_GCM_SHA384:
                  name: 'ECDHE-ECDSA-AES256-GCM-SHA384'
                  enabled: True
              buffer_size: '16k'
              crl:
                file: '/etc/ssl/crl.pem'
                enabled: False
              dhparam:
                enabled: True
                numbits: 2048
              ecdh_curve:
                secp384r1:
                  name: 'secp384r1'
                  enabled: False
                secp521r1:
                  name: 'secp521r1'
                  enabled: True
              password_file:
                content: 'testcontent22'
                enabled: True
                file: '/etc/ssl/password.key'
              prefer_server_ciphers: 'on'
              ticket_key:
                enabled: True
                numbytes: 48
              resolver:
                address: '127.0.0.1'
                valid_seconds: '500'
                timeout_seconds: '60'
              session_tickets: 'on'
              stapling: 'off'
              stapling_file: '/path/to/stapling/file'
              stapling_responder: 'http://ocsp.example.com/'
              stapling_verify: 'on'
              verify_client: 'on'
              client_certificate:
                file: '/etc/ssl/client_cert.pem'
                enabled: False
              verify_depth: 1
              session_cache: 'shared:SSL:15m'
              session_timeout: '15m'
              strict_transport_security:
                max_age: 16000000
                include_subdomains: False
                always: true
                enabled: true

Setting custom proxy headers:

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          custom_headers:
            type: nginx_proxy
            proxy_set_header:
              Host:
                enabled: true
                value: "$host:8774"
              X-Real-IP:
                enabled: true
                value: '$remote_addr'
              X-Forwarded-For:
                enabled: true
                value: '$proxy_add_x_forwarded_for'
              X-Forwarded-Proto:
                enabled: true
                value: '$scheme'
              X-Forwarded-Port:
                enabled: true
                value: '$server_port'

Define site catalog indexes:

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          nginx_catalog:
            enabled: true
            type: nginx_static
            name: server
            indexes:
            - index.htm
            - index.html
            host:
              name: 127.0.0.1
              port: 80

Define site catalog autoindex:

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          nginx_catalog:
            enabled: true
            type: nginx_static
            name: server
            autoindex: True
            host:
              name: 127.0.0.1
              port: 80

Nginx stats server (required by collectd nginx plugin) (DEPRECATED):

.. code-block:: yaml

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

or:

.. code-block:: yaml

    nginx:
      server:
        enabled: true
        site:
          nginx_stats_server:
            enabled: true
            root: disabled
            indexes: []
            stats: True
            type: nginx_static
            name: stat_server
            host:
              name: 127.0.0.1
              address: 127.0.0.1
              port: 8888

Nginx configured to wait for another service/s before
starting (currently only with systemd):

.. code-block:: yaml

    nginx:
      server:
        wait_for_service:
          - foo-bar.mount
        enabled: true
        site:
          ...

More Information
================

* http://wiki.nginx.org/Main
* https://wiki.mozilla.org/Security/Server_Side_TLS#Modern_compatibility
* http://nginx.com/resources/admin-guide/reverse-proxy/
* https://mozilla.github.io/server-side-tls/ssl-config-generator/

Documentation and Bugs
======================

* http://salt-formulas.readthedocs.io/
   Learn how to install and update salt-formulas

* https://github.com/salt-formulas/salt-formula-nginx/issues
   In the unfortunate event that bugs are discovered, report the issue to the
   appropriate issue tracker. Use the Github issue tracker for a specific salt
   formula

* https://launchpad.net/salt-formulas
   For feature requests, bug reports, or blueprints affecting the entire
   ecosystem, use the Launchpad salt-formulas project

* https://launchpad.net/~salt-formulas-users
   Join the salt-formulas-users team and subscribe to mailing list if required

* https://github.com/salt-formulas/salt-formula-nginx
   Develop the salt-formulas projects in the master branch and then submit pull
   requests against a specific formula

* #salt-formulas @ irc.freenode.net
   Use this IRC channel in case of any questions or feedback which is always
   welcome
