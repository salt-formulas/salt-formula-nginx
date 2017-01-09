
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

Static site with access policy

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_static_site01:
            enabled: true
            type: static
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

Proxy with access policy

.. code-block:: yaml

    nginx:
      server:
        site:
          nginx_proxy_site01:
            enabled: true
            type: proxy
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

Development and testing
=======================

Development and test workflow with `Test Kitchen <http://kitchen.ci>`_ and
`kitchen-salt <https://github.com/simonmcc/kitchen-salt>`_ provisioner plugin.

Test Kitchen is a test harness tool to execute your configured code on one or more platforms in isolation.
There is a ``.kitchen.yml`` in main directory that defines *platforms* to be tested and *suites* to execute on them.

Kitchen CI can spin instances locally or remote, based on used *driver*.
For local development ``.kitchen.yml`` defines a `vagrant <https://github.com/test-kitchen/kitchen-vagrant>`_ or
`docker  <https://github.com/test-kitchen/kitchen-docker>`_ driver.

To use backend drivers or implement your CI follow the section `INTEGRATION.rst#Continuous Integration`__.

A listing of scenarios to be executed:

.. code-block:: shell

  $ kitchen list

  Instance                    Driver   Provisioner  Verifier  Transport  Last Action

  horizon-no-ssl-ubuntu-1404    Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  horizon-no-ssl-ubuntu-1604    Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  horizon-no-ssl-centos-71      Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  horizon-with-ssl-ubuntu-1404  Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  horizon-with-ssl-ubuntu-1604  Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  horizon-with-ssl-centos-71    Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  proxy-ubuntu-1404             Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  proxy-ubuntu-1604             Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  proxy-centos-71               Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  redirect-ubuntu-1404          Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  redirect-ubuntu-1604          Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  redirect-centos-71            Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  static-ubuntu-1404            Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  static-ubuntu-1604            Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  static-centos-71              Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  stats-ubuntu-1404             Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  stats-ubuntu-1604             Vagrant  SaltSolo     Inspec    Ssh        <Not Created>
  stats-centos-71               Vagrant  SaltSolo     Inspec    Ssh        <Not Created>

The `Busser <https://github.com/test-kitchen/busser>`_ *Verifier* is used to setup and run tests
implementated in `<repo>/test/integration`. It installs the particular driver to tested instance
(`Serverspec <https://github.com/neillturner/kitchen-verifier-serverspec>`_,
`InSpec <https://github.com/chef/kitchen-inspec>`_, Shell, Bats, ...) prior the verification is executed.


Usage:

.. code-block:: shell

 # list instances and status
 kitchen list

 # manually execute integration tests
 kitchen [test || [create|converge|verify|exec|login|destroy|...]] [instance] -t tests/integration

 # use with provided Makefile (ie: within CI pipeline)
 make kitchen

