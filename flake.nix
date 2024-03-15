{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { nixpkgs, disko, agenix, ... }@inputs: {
    nixosConfigurations = {
      kyubey = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/kyubey

          disko.nixosModules.disko

          ({ ... }: { networking.hostName = "kyubey"; })
        ];
      };
      kyoko = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/kyoko

          agenix.nixosModules.default

          ({ ... }: {
            networking = {
              hostName = "kyoko";
              domain = "mxkrsv.dev";
            };
          })
        ];
      };
    };
  };
}
