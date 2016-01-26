
nginx:
  server:
    enabled: true
    extras: false
    bind:
      address: 127.0.0.1
      protocol: tcp
    site:
      nginx_redirect_site01:
        enabled: true
        type: nginx_redirect
        name: site01
        host:
          name: cloudlab.domain.com

