
=============
Nginx Formula
=============

Nginx is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage.

Sample Pillars
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
            type: nginx_static
            name: site01
            host:
              name: gitlab.domain.com
              port: 80

Simple load balancer

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

Static site with access policy

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

Simple TCP/UDP proxy

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

Simple HTTP proxy

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

Simple HTTP proxy with multiple locations
If proxy part is defined and location is missing `/`, then proxy part is used. If `/` location is defined then it overrides proxy part. 

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

Simple Websocket proxy

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

Content filtering proxy

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

Proxy with access policy

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
            type: nginx_proxy
            proxy:
              request_buffer: false
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

SSL using already deployed key and cert file.
Note that cert file should already contain CA cert and complete chain.

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

Nginx stats server (required by collectd nginx plugin)

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

Change nginx server ssl protocol options in openstack/proxy.yml

.. code-block:: yaml
    nginx:
      server:
        site:
          site01:
            enabled: true
            name: site01
            host:
              name: site01.domain.com
            ssl:
              enabled: true
              key_file:  /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}.key
              cert_file: /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}.crt
              chain_file: /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}-with-chain.crt
              protocols: TLSv1 TLSv1.1 TLSv1.2
              ciphers: "ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS"
              prefer_server_ciphers: true
              ecdh_curve: secp521r1

More Information
================

* http://wiki.nginx.org/Main
* https://wiki.mozilla.org/Security/Server_Side_TLS#Modern_compatibility
* http://nginx.com/resources/admin-guide/reverse-proxy/
* https://mozilla.github.io/server-side-tls/ssl-config-generator/


Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-nginx/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-nginx

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
