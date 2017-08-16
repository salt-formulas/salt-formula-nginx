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
          name: horizon.ci.local
        ssl:
          enabled: true
          key: |
            -----BEGIN RSA PRIVATE KEY-----
            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
            -----END RSA PRIVATE KEY-----
          cert: |
            -----BEGIN CERTIFICATE-----
            MIIE3jCCA0agAwIBAgIMWQmRtQWP7bWTfSYmMA0GCSqGSIb3DQEBCwUAMEgxFTAT
            BgNVBAMTDGNsb3VkIGRldm9wczERMA8GA1UEChMIbWlyYW50aXMxDzANBgNVBAgT
            BlByYWd1ZTELMAkGA1UEBhMCQ1owHhcNMTcwNTAzMDgxNTQ5WhcNMjcwNTAxMDgx
            NTQ5WjBVMREwDwYDVQQDEwh3aWxkY2FyZDEPMA0GA1UECxMGZGV2b3BzMREwDwYD
            VQQKEwhtaXJhbnRpczEPMA0GA1UECBMGUHJhZ3VlMQswCQYDVQQGEwJDWjCCAaIw
            DQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAKubKQC/QiGW3uvO6LnSLbbp+nIl
            8p6h5lW9MKqbyhe0sMKzoQDCDWRu66lGCviwLW35Od8q/JymiH/Anxn1TyJ0oCog
            P3Fuu5F1CfY0PVYJxPB5aCLY9xMZmCqEKTEfc0Cx1aOkM83p3dTA/i6EtBrrMNoS
            RDOOmzt0UXermBbeaMYk2FVZZeudZFFEVW7k59tsWQHon+0sIeMys5/IydFoWvT/
            qAyTaO+FNpOaEZ0QalMYYLO3mW6c0j2dgKG0geXfj5pV6/KBwRh0yCeu6AiVaZ/C
            27ROEX7JNv7P5obn4V0TX3co/l2fE19mO5mfOhfImXS4TBFxJGoI4tPpbphYLVIa
            mGi0VONJQ69Yn8KzgphcdquCZI5fW2w2fnJLmt7j2q+/9CUtmRlte5lP0+p639lM
            TWu/6+o0uVygjES5kx+5odtT16Q7hbq7JwFaTomUZLPONCr43SMF/Gx1RXfhOOZy
            w4Y1jYUY7L0cpmX0N3UaDjBRz/3qDrs0J8Ru8QIDAQABo4G6MIG3MAwGA1UdEwEB
            /wQCMAAwQQYDVR0RBDowOIIHKi5sb2NhbIIKKi5jaS5sb2NhbIIIKi5jaS5kZXaC
            CSouY2kudGVzdIIMKi5jaS5zdGFnaW5nMBMGA1UdJQQMMAoGCCsGAQUFBwMBMA8G
            A1UdDwEB/wQFAwMHIAAwHQYDVR0OBBYEFGtBfuF1lejUs6Bh87nkCgrjv3UuMB8G
            A1UdIwQYMBaAFIrt2HX5Q/vHJHZpGDTbhUoF09qfMA0GCSqGSIb3DQEBCwUAA4IB
            gQAud7sUeG4nCAY9GaeswvRQL58GqJEkfYFXSzWcxwluyTsz/z/7CQiNG77/jHPs
            IvJBt79uFQWL8YINrdzMIGRpHLpTT6g7hRDtx0T0tzj28bu4twayu9ePMPQIgh/3
            ISJBIIeJIKQ/EWCm+3ePKKZWp3OscxPUdSLNf+3dmvSWmjdazhq5F/d5i4u5Fqur
            iHaw6P/bGd2yqSiiYC1Csr1+Rfe+ulyk1NUBtpewX/96KjWNlU7q9F3RxiTNxh7x
            CDJf5DBHIQP/KCquq8T3uZAOV2sN+HGvO4OzelisnzmRuRm8Lk4ZYNPXFTugdysY
            HZk3aBIfowkAbNGsGOaiLkc80GxDwXXGCvTLHUXtPYH+Dkw1PRZkP+UhxT9b70El
            qaZkfvfWEum90BH0km+1dPB/mBMqoTRXVmRyrc2QFsxRGenDbM5RhcT4HfgxCyzC
            J2EGz8Wzf1bn2kRR4uomSzcoLe8lCM79M+DY21dxP0V8dq2sNvHOqP/0HT62BlEq
            XtI=
            -----END CERTIFICATE-----
          chain: |
            -----BEGIN CERTIFICATE-----
            MIIE3jCCA0agAwIBAgIMWQmRtQWP7bWTfSYmMA0GCSqGSIb3DQEBCwUAMEgxFTAT
            BgNVBAMTDGNsb3VkIGRldm9wczERMA8GA1UEChMIbWlyYW50aXMxDzANBgNVBAgT
            BlByYWd1ZTELMAkGA1UEBhMCQ1owHhcNMTcwNTAzMDgxNTQ5WhcNMjcwNTAxMDgx
            NTQ5WjBVMREwDwYDVQQDEwh3aWxkY2FyZDEPMA0GA1UECxMGZGV2b3BzMREwDwYD
            VQQKEwhtaXJhbnRpczEPMA0GA1UECBMGUHJhZ3VlMQswCQYDVQQGEwJDWjCCAaIw
            DQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAKubKQC/QiGW3uvO6LnSLbbp+nIl
            8p6h5lW9MKqbyhe0sMKzoQDCDWRu66lGCviwLW35Od8q/JymiH/Anxn1TyJ0oCog
            P3Fuu5F1CfY0PVYJxPB5aCLY9xMZmCqEKTEfc0Cx1aOkM83p3dTA/i6EtBrrMNoS
            RDOOmzt0UXermBbeaMYk2FVZZeudZFFEVW7k59tsWQHon+0sIeMys5/IydFoWvT/
            qAyTaO+FNpOaEZ0QalMYYLO3mW6c0j2dgKG0geXfj5pV6/KBwRh0yCeu6AiVaZ/C
            27ROEX7JNv7P5obn4V0TX3co/l2fE19mO5mfOhfImXS4TBFxJGoI4tPpbphYLVIa
            mGi0VONJQ69Yn8KzgphcdquCZI5fW2w2fnJLmt7j2q+/9CUtmRlte5lP0+p639lM
            TWu/6+o0uVygjES5kx+5odtT16Q7hbq7JwFaTomUZLPONCr43SMF/Gx1RXfhOOZy
            w4Y1jYUY7L0cpmX0N3UaDjBRz/3qDrs0J8Ru8QIDAQABo4G6MIG3MAwGA1UdEwEB
            /wQCMAAwQQYDVR0RBDowOIIHKi5sb2NhbIIKKi5jaS5sb2NhbIIIKi5jaS5kZXaC
            CSouY2kudGVzdIIMKi5jaS5zdGFnaW5nMBMGA1UdJQQMMAoGCCsGAQUFBwMBMA8G
            A1UdDwEB/wQFAwMHIAAwHQYDVR0OBBYEFGtBfuF1lejUs6Bh87nkCgrjv3UuMB8G
            A1UdIwQYMBaAFIrt2HX5Q/vHJHZpGDTbhUoF09qfMA0GCSqGSIb3DQEBCwUAA4IB
            gQAud7sUeG4nCAY9GaeswvRQL58GqJEkfYFXSzWcxwluyTsz/z/7CQiNG77/jHPs
            IvJBt79uFQWL8YINrdzMIGRpHLpTT6g7hRDtx0T0tzj28bu4twayu9ePMPQIgh/3
            ISJBIIeJIKQ/EWCm+3ePKKZWp3OscxPUdSLNf+3dmvSWmjdazhq5F/d5i4u5Fqur
            iHaw6P/bGd2yqSiiYC1Csr1+Rfe+ulyk1NUBtpewX/96KjWNlU7q9F3RxiTNxh7x
            CDJf5DBHIQP/KCquq8T3uZAOV2sN+HGvO4OzelisnzmRuRm8Lk4ZYNPXFTugdysY
            HZk3aBIfowkAbNGsGOaiLkc80GxDwXXGCvTLHUXtPYH+Dkw1PRZkP+UhxT9b70El
            qaZkfvfWEum90BH0km+1dPB/mBMqoTRXVmRyrc2QFsxRGenDbM5RhcT4HfgxCyzC
            J2EGz8Wzf1bn2kRR4uomSzcoLe8lCM79M+DY21dxP0V8dq2sNvHOqP/0HT62BlEq
            XtI=
            -----END CERTIFICATE-----
            -----BEGIN CERTIFICATE-----
            MIIEWTCCAsGgAwIBAgIMWQmRjiv/O7NwT3AxMA0GCSqGSIb3DQEBCwUAMEgxFTAT
            BgNVBAMTDGNsb3VkIGRldm9wczERMA8GA1UEChMIbWlyYW50aXMxDzANBgNVBAgT
            BlByYWd1ZTELMAkGA1UEBhMCQ1owHhcNMTcwNTAzMDgxNTEwWhcNMjcwNTAxMDgx
            NTEwWjBIMRUwEwYDVQQDEwxjbG91ZCBkZXZvcHMxETAPBgNVBAoTCG1pcmFudGlz
            MQ8wDQYDVQQIEwZQcmFndWUxCzAJBgNVBAYTAkNaMIIBojANBgkqhkiG9w0BAQEF
            AAOCAY8AMIIBigKCAYEAyIW/3H2CIvnkflCm4bc9im8TeoE+s/W/OI80d1cgfnVY
            VRvQMuhfKMV9Ec83qaMoT/VD2TLGoaLTKxvn05jpYd7lFf+ekZXPC1tK+Wgj5w38
            c/V+tux6uYMPDo9XoHkGqakqE0Y9PkiUcsiOhCXMzrr3SkkpHqLV32kEKz711ibi
            h4ATeYou7Q0hsRqRfjRj/JAr+nVQiZM39jm1OvA7VYgIrppu2rSSJwsOhneG2dhP
            EEhpTSWB/kMPmxMQygKGZc08noZsReC7U5F+n2+DDkhdvQtQUqN2UZ4iCWt1aMxd
            FDYmXm0uB6utJCsxy3uf4Mkfb86RBI5owECel4ASTQcAIRQNsFcaQg408c+sXTuB
            44RZBgJY6re2UEGGUiZ0i7mAR07Ava3dve2Rm24t2Lg17WIuIQC+kqIbgvnj9KtS
            w00JyXFCrbiYmxpx286X27ca7sLGZZnpSNfoGvfX1UFlmmK/89klR+kMktgGdka6
            pnfbGDLfS5h7AkZnjzAnAgMBAAGjQzBBMA8GA1UdEwEB/wQFMAMBAf8wDwYDVR0P
            AQH/BAUDAwcGADAdBgNVHQ4EFgQUiu3YdflD+8ckdmkYNNuFSgXT2p8wDQYJKoZI
            hvcNAQELBQADggGBAGkWleGTCwl5v9DyL+ReQ7cIsZp2FZCPATWjrlY69QNpa7s/
            h7gS0Lx1bmwSVyM/A7DrmHUz2ScUjJJeZuOAt2LaKl8rnMJMSRIj4WosIB886bOw
            d6polbiVWRFUGEaD/X9L4AJFLE3X8ITuwd4ukwCB4IvEuPLhDVIFHFIk2ur7n0HF
            XsE/SNmsRuULMXLEqguWmCXhHqsbFoBrmUdUIyVPav9j/XFc/3jG5kAn25Qz9LfV
            cX1LJihPbtCrc1LtBqV0LrV6aFwcl8c9JFR3qha19za/Fk/JnKz1E6CbVWMLLSOo
            +fTGf4nvof/jJS61vKwRE3lyxZNciiXQV4fGVRIrVkbULbNSgmQaFtNFBwQ07w61
            5ks8/gGnwHKnNc9kQdPm8nNjY7Jqp9XI8RaLoLvqaTAqcempwiyPYT8qu3JE79Dl
            6Jw10sI4/PqU5XVTqSCrvmICOOgZbFRWgCLwJzp5rq0cWvJH0N5PyATL6FfhDGm0
            myUGszN7wRKeJqKa1w==
            -----END CERTIFICATE-----
          protocols: TLSv1.2
          ciphers: "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256"
          prefer_server_ciphers: false
          ecdh_curve: secp384r1
horizon:
  server:
    enabled: true
    secret_key: secret
    app:
      site01:
        bind:
          port: 80
