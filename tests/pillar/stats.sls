
nginx:
  server:
    enabled: true
    extras: false
    bind:
      address: 127.0.0.1
      protocol: tcp
    site:
      nginx_stats_server:
        enabled: true
        type: nginx_stats
        name: server
        host:
          name: 127.0.0.1
          port: 8888

