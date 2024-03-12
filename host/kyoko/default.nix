{ ... }: {
  imports = [
    ../common

    ./certs.nix
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  boot.cleanTmpDir = true;

  zramSwap.enable = true;
}
