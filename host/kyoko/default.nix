{ ... }: {
  imports = [
    ../common
    ../common/virtual

    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  boot.cleanTmpDir = true;

  zramSwap.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGpUBOdwjO4iYwQiPQ9vDtvolAas4rBzp/Bc2tv0Zk8h mxkrsv@homura''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkupsms0fUp4SflgKwVBfKRXi8eY51cgbex4aXerC5B mxkrsv@sayaka''
  ];

  system.stateVersion = "23.11";
}
