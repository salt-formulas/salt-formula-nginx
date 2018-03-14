salt:
  minion:
    enabled: true
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
      unbound:
        host:
          bind: 127.0.0.1
          port: 53
          protocol: udp
        backend:
          server1:
            address: 10.10.10.114
            port: 5353
    enabled: true
    extras: false
    bind:
      address: 127.0.0.1
      protocol: tcp
    upstream:
      horizon-upstream:
        backend1:
          address: 10.10.10.113
          port: 8078
          opts: weight=3
        backend2:
          address: 10.10.10.114
    site:
      nginx_proxy_site01:
        enabled: true
        type: nginx_proxy_locations
        name: site01
        proxy:
          locations:
            /:
              host: 172.10.10.100
              port: 80
              protocol: http
              size: 10000m
              timeout: 43200
              websocket: true
              request_buffer: false
              buffer:
                number: 4
                size: 256
            /doc/:
              host: 172.10.10.200
              port: 80
              protocol: http
        host:
          name: cloudlab.domain.com
          port: 80
      nginx_proxy_site02:
        enabled: true
        type: nginx_proxy
        name: site02
        proxy:
          upstream_proxy_pass: http://horizon-upstream
        host:
          name: cloudlab.domain.com
          port: 31337
