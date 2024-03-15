{ pkgs, config, ... }: {
  # Requires ACME
  services.shadowsocks = {
    enable = true;
    port = 443;

    plugin = "${pkgs.shadowsocks-v2ray-plugin}/bin/v2ray-plugin";
    pluginOpts = "server;tls;host=${config.networking.hostName}.${config.networking.domain}";
  };
}
