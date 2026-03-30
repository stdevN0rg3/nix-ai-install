{
  description = "Nix/NixOS support for AI tools - gentle-ai and more";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          gentle-ai = import ./modules/gentle-ai/package.nix { inherit pkgs; };
          default = self.packages.${system}.gentle-ai;
        };

        legacyPackages = {
          gentle-ai = self.packages.${system}.gentle-ai;
        };
      }
    ) // {
      # NixOS module - can be imported in NixOS configurations
      nixosModule = import ./modules/gentle-ai/default.nix;

      # Home Manager module - can be imported in home-manager configurations
      homeManagerModule = import ./modules/gentle-ai/default.nix;
    };
}
