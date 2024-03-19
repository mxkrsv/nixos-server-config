{ config, ... }: {
  networking.firewall.allowedTCPPorts = [ 443 ];

  services.sing-box = {
    enable = true;

    settings =
      let
        host = "${config.networking.hostName}.${config.networking.domain}";
        certPath = "${config.security.acme.certs.${host}.directory}";
      in
      {
        inbounds = [
          {
            type = "vless";
            tag = "vless-in";

            listen = "::";
            listen_port = 443;

            users = [
              {
                name = "mxkrsv";
                uuid = {
                  _secret = config.age.secrets.singbox_uuid_mxkrsv.path;
                };
              }
            ];

            tls = {
              server_name = host;
              certificate_path = "${certPath}/cert.pem";
              key_path = "${certPath}/key.pem";
            };
          }
        ];

        outbounds = [
          {
            type = "direct";
            tag = "direct";
          }
        ];
      };
  };
}
