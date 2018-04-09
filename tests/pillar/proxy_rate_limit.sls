_dollar: '$'
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
      nginx_proxy_site01:
        enabled: true
        type: nginx_proxy
        name: site01
        proxy:
          host: 127.0.0.1
          port: 808
          protocol: http
        host:
          name: cloudlab.domain.com
          port: 31337
          limit:
            enabled: True
            ip_whitelist:
            - 127.0.0.1
            burst: 600
            rate: 10r/s
            nodelay: True
            subfilters:
              show_active_instance:
                input: ${_dollar}{binary_remote_addr}${_dollar}{request_uri}
                mode: blacklist
                items:
                - "~.*servers/detail[?]name=.*&status=ACTIVE"
                rate: 2r/m
                burst: 2
                nodelay: True
              server_list:
                input: ${_dollar}{binary_remote_addr}${_dollar}{request_uri}
                mode: blacklist
                items:
                - "~.*servers/detail$"
                rate: 30r/m
                burst: 20
                nodelay: True
