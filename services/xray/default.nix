{ config, ... }: {
  services.xray =
    let
      host = "${config.network.hostName}.${config.network.domain}";
      certPath = "${config.security.acme.certs.${host}.directory}";
    in
    {
      enable = true;

      settings = {
        log.loglevel = "info";

        inbounds = [
          {
            listen = "0.0.0.0";
            port = 443;
            protocol = "vless";
            tag = "kyoko-vless-tls-in";

            settings = {
              decryption = "none";

              clients = [
                {
                  id = config.age.secrets.xray_uuid_mxkrsv;
                  email = "mxkrsv@disroot.org";
                  level = 0;
                }
              ];
            };

            streamSettings = {
              network = "tcp";
              security = "tls";
              tlsSettings = {
                serverName = host;
                certificates = [
                  {
                    certificateFile = "${certPath}/cert.pem";
                    keyFile = "${certPath}/key.pem";
                  }
                ];
              };
            };

            sniffing = {
              enabled = true;
              destOverride = [
                "http"
                "tls"
                "quic"
              ];
            };
          }
        ];

        outbounds = [
          {
            protocol = "freedom";
            tag = "direct";
          }
          {
            protocol = "blackhole";
            tag = "block";
          }
        ];

        routung = {
          domainStrategy = "IPIfNonMatch";

          rules = [
            {
              type = "field";
              protocol = "bittorrent";
              outboundTag = "block";
            }
          ];
        };
      };
    };
}
