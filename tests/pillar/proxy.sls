
nginx:
  server:
    enabled: true
    extras: false
    bind:
      address: 127.0.0.1
      protocol: tcp
    site:
      nginx_proxy_site01:
        enabled: true
        type: nginx_proxy
        name: site01
        proxy:
          host: 172.10.10.100
          port: 80
          protocol: http
        host:
          name: cloudlab.domain.com
          port: 80

