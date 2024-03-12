{ config, ... }: {
  security.acme = {
    defaults = {
      email = "mxkrsv+acme@disroot.org";
    };

    certs = {
      "${config.networking.hostName}.${config.networking.domain}" = { };
    };
  };
}
