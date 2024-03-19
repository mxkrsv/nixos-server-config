{ ... }: {
  age.secrets = {
    porkbun_api_key.file = ../../secrets/porkbun_api_key.age;
    porkbun_secret_api_key.file = ../../secrets/porkbun_secret_api_key.age;

    xray_uuid_mxkrsv.file = ../../secrets/xray_uuid_mxkrsv;
  };
}
