# NixOS and Home Manager module for gentle-ai
# This module provides both NixOS system and Home Manager user configurations

{ lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.gentle-ai;
in
{
  options.programs.gentle-ai = {
    enable = mkEnableOption "gentle-ai - AI Agents Installer";

    package = mkOption {
      type = types.package;
      default = pkgs.gentle-ai;
      defaultText = "pkgs.gentle-ai";
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
    # NixOS system configuration
    environment.systemPackages = [ cfg.package ];

    # Home Manager user configuration
    home.packages = [ cfg.package ];

    home.file."${cfg.installPath}/gentle-ai" = mkIf cfg.createWrapper {
      source = cfg.package;
      executable = true;
    };
  };
}
