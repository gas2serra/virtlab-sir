#!/bin/sh
# session hook script; write commands here to execute on the host at the
# specified state

CERT_DIR=$SESSION_DIR/certs
mkdir $CERT_DIR

cat > $CERT_DIR/dh2048.pem <<EOF
-----BEGIN DH PARAMETERS-----
MIIBCAKCAQEAr4EyM7+wOHR5bZsHIGDEfrGLAKcLpt3Mfx2ZeyBVqjIfdFVjYHlu
6RtsmyjLCACeyaf9fGW6LcsHzuBIBLXIFEKLWOTjf5BS1Zs7xL/zB8JZhQOhG9FD
lPxCFpVAsfHii4RW/CJeEbNemrPWpzvelyrj2xcvTVo34U7mkNjZkkVkDba6RZWG
gAPCDc7cpGrjB59ggFiVDssBY2WJXUH380om6eMUiOICdibLs3H01YDboNeK/RlS
yV0V1QDPIwZWMq2enHPu1Gb70r43Y4+ttK3CCI1dNgBmYsc5nzOLEz5zmgkgNkx1
pCGJcYvfp9oQFkdWwv2ALv+Q4pDLpnw1KwIBAg==
-----END DH PARAMETERS-----
EOF

cat > $CERT_DIR/ca-cert.pem <<EOF
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 14877806922217260285 (0xce789691db9b84fd)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, ST=WA, O=core-dev/emailAddress=root@localhost
        Validity
            Not Before: May 19 02:09:57 2015 GMT
            Not After : Apr 25 02:09:57 2115 GMT
        Subject: C=US, ST=WA, O=core-dev/emailAddress=root@localhost
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (4096 bit)
                Modulus:
                    00:bc:0a:6e:71:01:f7:e4:7d:4b:88:94:08:46:28:
                    9d:ee:f1:9d:10:b1:a2:9d:42:ab:71:f1:e1:bc:16:
                    a7:b8:6e:d6:30:e6:f3:b0:c0:b7:a9:8b:86:f3:13:
                    25:95:89:00:48:29:b7:83:f7:db:27:1d:b8:0a:bc:
                    b2:e3:a8:c7:4a:e6:89:6e:04:6d:fb:db:2e:de:48:
                    6a:4b:3b:82:2a:19:21:c6:8c:ab:7d:13:3e:79:93:
                    64:66:c0:85:82:be:af:76:e0:c8:f2:7f:67:62:25:
                    bb:d5:cc:e2:f0:f0:14:3a:9f:1e:62:d2:8b:df:72:
                    e0:bf:01:b9:28:da:8d:4e:f9:f2:94:7f:20:1c:cd:
                    8d:07:a0:b1:e9:47:a9:57:57:c0:75:29:d1:f9:11:
                    61:55:20:34:9f:5a:1d:01:d8:4a:53:44:08:f7:2d:
                    bc:0e:75:29:bb:94:be:47:17:65:bf:50:88:85:c7:
                    3b:12:bd:46:34:12:41:e5:55:b4:5b:59:67:8b:d9:
                    53:7d:2f:dc:34:78:b1:f9:b0:3c:e8:fe:fe:65:43:
                    6b:e4:00:06:e3:df:d8:0a:06:62:7c:6a:e4:68:e6:
                    68:88:98:49:59:c3:41:76:f1:fe:d7:0a:6d:a4:f4:
                    4d:0a:cb:2a:94:a9:b2:4b:b5:fb:10:bb:7d:31:83:
                    a2:42:e0:77:27:72:25:0e:55:19:c2:76:22:cd:ed:
                    9c:8e:8f:49:35:d2:ea:a1:5d:65:be:93:8b:e7:06:
                    d5:a0:51:d3:ad:c0:8b:81:64:89:81:e2:c0:6e:d6:
                    85:07:3c:22:8d:0b:c1:70:5f:c5:1d:62:03:3a:d3:
                    4b:f5:5d:83:15:fe:08:86:d1:c7:2a:a2:62:73:fb:
                    9e:f4:2f:cb:dd:55:1b:05:16:2c:0b:2b:b4:f2:78:
                    f5:59:f6:5a:34:62:6c:b8:f1:d4:b8:24:fe:b8:91:
                    99:ad:27:fc:52:05:60:45:11:dc:b0:63:b5:4e:3f:
                    c7:19:c4:93:a1:06:5f:b2:52:51:4e:17:b5:9a:49:
                    08:03:c0:0b:2f:10:8c:17:fb:76:e8:00:6f:f1:5f:
                    2b:c6:50:26:df:35:aa:f7:ba:67:65:10:43:b6:96:
                    1a:e7:42:22:a0:f3:67:00:74:6c:66:5e:61:ab:76:
                    f6:2e:98:a8:b5:03:eb:0b:c5:9c:ad:23:e8:b3:3a:
                    23:11:c1:28:58:88:a7:a8:ef:1c:69:0e:3a:37:29:
                    92:43:fb:64:5f:88:0c:ff:ee:76:55:51:55:0d:79:
                    89:63:a6:fd:33:d0:fc:34:d2:8c:fa:52:0b:f1:7f:
                    71:e1:e7:be:7e:31:d5:d9:3a:b7:2b:74:fe:d2:77:
                    28:22:19
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Key Identifier: 
                DB:D2:9C:8D:22:D9:D7:E2:38:A0:8D:6C:3B:BE:33:CE:8D:2A:BE:C8
            X509v3 Authority Key Identifier: 
                keyid:DB:D2:9C:8D:22:D9:D7:E2:38:A0:8D:6C:3B:BE:33:CE:8D:2A:BE:C8
                DirName:/C=US/ST=WA/O=core-dev/emailAddress=root@localhost
                serial:CE:78:96:91:DB:9B:84:FD

            X509v3 Basic Constraints: 
                CA:TRUE
            X509v3 Key Usage: 
                Certificate Sign, CRL Sign
    Signature Algorithm: sha256WithRSAEncryption
         9b:3e:53:96:8e:70:3d:b0:cb:95:11:e2:96:19:14:b4:39:80:
         8f:55:6e:e5:51:3d:b3:a3:67:f5:58:a0:a4:11:86:99:38:22:
         a2:64:27:8b:9b:e4:e4:12:1d:ca:74:23:24:a7:5d:7c:0d:9e:
         6c:03:87:33:8f:63:98:12:f5:ce:29:6e:ff:26:fd:c9:e3:60:
         35:21:41:1f:da:07:8c:3b:28:cf:34:d3:61:50:90:fe:3e:67:
         a4:0d:77:6b:d2:f8:b4:72:3e:bf:b8:59:a0:dc:b6:cf:04:49:
         47:da:dc:b1:2f:13:d2:6b:2d:c5:af:cc:e5:d1:68:ae:f4:b9:
         7a:33:18:f3:6f:2a:d7:be:48:41:b3:30:e1:0a:f6:eb:c7:18:
         ec:5f:0f:ee:a0:11:0e:0a:79:80:7e:2d:cb:9f:3e:e2:46:85:
         c8:4a:97:5a:18:19:b9:1d:1d:2c:69:32:eb:c1:d1:06:98:e9:
         fc:75:69:11:4b:28:2a:1c:c5:0d:91:2c:1f:40:79:f5:82:9e:
         6f:16:d8:00:5e:c4:ec:e0:3f:34:25:9f:53:74:61:75:ea:03:
         2f:2a:79:2f:cc:db:63:60:44:b1:e3:07:a3:30:37:83:77:b8:
         03:f6:05:fd:89:b7:c7:f9:f9:d6:48:f1:29:52:c2:51:aa:9b:
         ae:3d:e8:5f:17:a6:93:94:e5:18:06:02:fd:01:50:17:00:26:
         27:e8:93:bc:09:a4:b6:47:ce:37:8b:d0:3d:0c:03:9c:a9:30:
         80:12:64:84:ec:bd:7f:72:82:84:58:29:0d:26:dc:cc:da:c4:
         d4:f5:2b:6a:75:a0:6e:88:f1:10:67:63:55:b3:24:f9:a7:4f:
         92:94:65:5f:10:69:84:1a:26:e0:a9:d6:75:93:17:16:c4:1b:
         49:71:c4:3c:0d:a1:27:92:bd:9a:7e:5b:71:96:b6:20:55:3b:
         63:0c:7b:75:13:36:a4:bf:df:f7:5d:44:13:f2:89:12:0e:4a:
         52:a5:7f:3e:6f:d5:2e:65:8e:20:07:94:0d:4e:cd:1c:a9:4f:
         be:20:67:3c:b0:f9:15:84:62:1c:5f:09:9e:c4:78:95:4b:a8:
         4d:24:e8:22:b0:bd:57:d7:00:ea:37:97:3e:35:02:89:51:fe:
         13:d2:1c:e9:86:48:40:82:e1:ed:2f:fa:9c:6a:99:9e:82:9c:
         15:b8:e1:ba:1e:0f:a6:bb:d2:23:4e:07:94:d6:99:b9:4b:36:
         5b:f6:87:91:42:17:5e:7e:57:b0:e5:9a:d1:00:4d:f6:e0:f2:
         af:02:c7:bf:0b:0d:3a:5f:02:e9:ff:c7:ca:7b:43:47:05:aa:
         9c:4b:8f:7d:cb:e0:79:96
-----BEGIN CERTIFICATE-----
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
e0NHBaqcS499y+B5lg==
-----END CERTIFICATE-----
EOF


