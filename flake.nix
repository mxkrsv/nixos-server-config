{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    disko.url = "github:nix-community/disko";
  };

  outputs = { nixpkgs, disko, ... }@inputs: {
    nixosConfigurations = {
      kyubey = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
	  disko.nixosModules.disko
        ];
      };
    };
  };
}
