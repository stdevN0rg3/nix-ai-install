# gentle-ai Module

Nix/NixOS support for [Gentle AI](https://github.com/Gentleman-Programming/gentle-ai) installer.

## Why This Exists

The gentle-ai installer doesn't support NixOS due to edge cases around:
- Home Manager symlinks to immutable nix store paths
- Self-update path undefined (nix store is read-only)
- Backup system conflicts with nix store symlinks

For NixOS users, we recommend installing the binary manually to `~/.local/bin` or using this flake/home-manager module.

## Usage

### Option 1: Flake

Add to your `flake.nix`:

```nix
{
  inputs.nix-ai-install.url = "github:norge/nix-ai-install";
}
```

Then use the module:

```nix
outputs@{ self, nixpkgs, nix-ai-install, ... }: {
  # For system packages (NixOS)
  nixosConfigurations.yourHostname = nixpkgs.lib.nixosSystem {
    modules = [
      nix-ai-install.nixosModule
      ({ programs.gentle-ai.enable = true; })
    ];
  };

  # Or for home-manager
  homeConfigurations."yourUsername" = home-manager.lib.homeManagerConfiguration {
    modules = [
      nix-ai-install.homeManagerModule
      ({ programs.gentle-ai.enable = true; })
    ];
  };
}
```

### Option 2: Home Manager Only

If you already have home-manager configured:

```nix
{
  imports = [ (nix-ai-install + "/homeManagerModule") ];

  programs.gentle-ai = {
    enable = true;
  };
}
```

## Configuration

### Module Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enable` | boolean | `false` | Enable gentle-ai |
| `package` | package | auto | Custom package override |
| `installPath` | string | `~/.local/bin` | Where to install the binary |
| `createWrapper` | boolean | `true` | Create wrapper for self-update |

## Requirements

- Nix 2.4+ (for flake support)
- Home Manager (for the home-manager module)

## Disclaimer

This is NOT officially supported by the gentle-ai maintainers. Use at your own risk.

## License

MIT - Same as gentle-ai
