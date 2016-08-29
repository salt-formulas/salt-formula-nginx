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
      limit_nofile: 30000
    site:
      nginx_static_site01:
        enabled: true
        type: nginx_static
        name: site01
        host:
          name: cloudlab.domain.com
          port: 80

