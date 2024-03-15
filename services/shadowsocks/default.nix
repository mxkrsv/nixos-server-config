{ pkgs, config, ... }: {
  networking.firewall.allowedTCPPorts = [ 443 ];

  # Requires ACME
  services.shadowsocks =
    let
      host = "${config.networking.hostName}.${config.networking.domain}";
      certPath = "${config.security.acme.certs.${host}.directory}";
    in
    {
      enable = true;
      port = 443;
      mode = "tcp_only";
      localAddress = [ "0.0.0.0" ];

      plugin = "${pkgs.shadowsocks-v2ray-plugin}/bin/v2ray-plugin";
      pluginOpts = "server;tls;host=${host};cert=${certPath}/cert.pem;key=${certPath}/key.pem";

      passwordFile = config.age.secrets.shadowsocks_password.path;
    };
}
