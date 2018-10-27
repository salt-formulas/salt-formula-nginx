salt:
  minion:
    enabled: true
nginx:
  server:
    enabled: true
    extras: false
    bind:
      address: 127.0.0.1
      protocol: tcp
    worker:
      limit:
        nofile: 30000
    site:
      nginx_static_site01:
        enabled: true
        type: nginx_static
        name: site01
        host:
          name: cloudlab.domain.com
          port: 80
      nginx_catalog1:
        enabled: true
        type: nginx_static
        name: server
        indexes:
        - index.htm
        - index.html
        host:
          name: 127.0.0.2
          port: 80
      nginx_catalog2:
        enabled: true
        type: nginx_static
        name: server
        autoindex: True
        host:
          name: 127.0.0.3
          port: 80
