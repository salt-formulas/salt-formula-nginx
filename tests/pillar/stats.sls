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
    site:
      nginx_stats_server:
        enabled: true
        type: nginx_stats
        name: server
        host:
          name: 127.0.0.1
          port: 8888
      nginx_stats_server2:
        enabled: true
        root: disabled
        stats: True
        indexes: []
        type: nginx_static
        name: stats_server
        host:
          name: 127.0.0.1
          address: 127.0.0.1
          port: 8889
