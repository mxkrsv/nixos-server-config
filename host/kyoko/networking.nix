{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    defaultGateway = "10.0.0.1";
    defaultGateway6 = {
      address = "2a12:5940:4887::1";
      interface = "ens3";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce true;
    interfaces = {
      ens3 = {
        ipv4.addresses = [
          { address = "147.45.77.147"; prefixLength = 32; }
        ];
        ipv6.addresses = [
          { address = "2a12:5940:4887::2"; prefixLength = 48; }
          { address = "fe80::5054:ff:fe17:1bc2"; prefixLength = 64; }
        ];
        ipv4.routes = [{ address = "10.0.0.1"; prefixLength = 32; }];
        ipv6.routes = [{ address = "2a12:5940:4887::1"; prefixLength = 128; }];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="52:54:00:17:1b:c2", NAME="ens3"
  '';
}
