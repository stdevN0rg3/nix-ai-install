# NixOS module for gentle-ai
# Use with: imports = [ nix-ai-install.nixosModule ];

{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.programs.gentle-ai;
in
{
  options.programs.gentle-ai = {
    enable = mkEnableOption "gentle-ai - AI Agents Installer";

    package = mkOption {
      type = types.package;
      description = "The gentle-ai package to use";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
