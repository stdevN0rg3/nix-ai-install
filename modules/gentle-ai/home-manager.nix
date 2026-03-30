# Home Manager module for gentle-ai
# Use with: imports = [ nix-ai-install.homeManagerModule ];

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

    installPath = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.local/bin";
      description = "Where to install the gentle-ai binary";
    };

    createWrapper = mkOption {
      type = types.bool;
      default = true;
      description = "Create a wrapper script for self-update compatibility";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file."${cfg.installPath}/gentle-ai" = mkIf cfg.createWrapper {
      source = cfg.package;
      executable = true;
    };
  };
}
