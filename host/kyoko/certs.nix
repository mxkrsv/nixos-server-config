{ config, ... }: {
  security.acme = {
    acceptTerms = true;

    defaults = {
      email = "mxkrsv+acme@disroot.org";
      dnsProvider = "porkbun";
      credentialFiles = {
        PORKBUN_API_KEY_FILE = config.age.secrets.porkbun_api_key.path;
        PORKBUN_SECRET_API_KEY_FILE = config.age.secrets.porkbun_secret_api_key.path;
      };
    };

    certs = {
      "${config.networking.hostName}.${config.networking.domain}" = { };
    };
  };
}
