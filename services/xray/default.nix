{ config, ... }: {
  services.xray =
    let
      host = "${config.networking.hostName}.${config.networking.domain}";
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
                  # TODO: in the nix store anyway; need to figure out a fix later
                  id = builtins.readFile config.age.secrets.xray_uuid_mxkrsv.path;
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
                    # TODO: have to put them to the store because of a check
                    # in the nixos module
                    certificateFile = /. + "${certPath}/cert.pem";
                    keyFile = /. + "${certPath}/key.pem";
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
