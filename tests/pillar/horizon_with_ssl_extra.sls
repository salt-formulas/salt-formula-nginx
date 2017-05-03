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
      horizon_site01:
        enabled: true
        type: horizon
        name: site01
        host:
          name: horizon.domain.com
        ssl:
          enabled: true
          authority: salt_master_ca
          ca_file: /etc/ssl/certs/RSA_Security_2048_v3.pem
          key_file: /etc/ssl/private/ssl-cert-snakeoil.key
          cert_file: /etc/ssl/certs/RSA_Security_2048_v3.pem
          chain_file: /tmp/temp_chain_file.crt
      horizon_site02:
        enabled: true
        type: horizon
        name: site02
        host:
          name: horizon.domain.com
        ssl:
          enabled: true
          engine: salt
          authority: salt_master_ca
          ca_file: /etc/ssl/certs/RSA_Security_2048_v3.pem
          key_file: /etc/ssl/private/ssl-cert-snakeoil.key
          cert_file: /etc/ssl/certs/RSA_Security_2048_v3.pem
          chain_file: /tmp/temp_chain_file02.crt

