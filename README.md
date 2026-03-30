# nix-ai-install

Nix/NixOS support for AI tools - a modular approach to install and manage AI applications on NixOS and Nix Darwin.

## Supported Tools

| Tool | Module | Description |
|------|--------|-------------|
| [gentle-ai](modules/gentle-ai) | `gentle-ai` | AI Agents Installer |

## Quick Start

### Add to your flake.nix

```nix
{
  inputs.nix-ai-install.url = "github:norge/nix-ai-install";
}
```

### Usage

#### Home Manager (recommended)

```nix
{
  inputs.nix-ai-install.url = "github:norge/nix-ai-install";
  inputs.home-manager.url = "github:nix-community/home-manager";

  outputs = { self, nixpkgs, home-manager, nix-ai-install, ... }: {
    homeConfigurations.norge = home-manager.lib.homeManagerConfiguration {
      modules = [
        nix-ai-install.homeManagerModule
        # Enable tools
        ({ programs.gentle-ai.enable = true; })
      ];
    };
  };
}
```

#### NixOS System

```nix
{
  inputs.nix-ai-install.url = "github:norge/nix-ai-install";

  outputs = { self, nixpkgs, nix-ai-install, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [
        nix-ai-install.nixosModule
        # Enable tools
        ({ programs.gentle-ai.enable = true; })
      ];
    };
  };
}
```

## Structure

```
nix-ai-install/
├── flake.nix                    # Main flake entry point
├── modules/
│   ├── gentle-ai/               # gentle-ai module
│   │   ├── package.nix         # Package definition
│   │   └── default.nix         # NixOS + Home Manager module
│   └── README.md                # Module documentation
└── README.md                    # This file
```

## Adding New Tools

To add a new AI tool:

1. Create a new directory under `modules/<tool-name>/`
2. Add `package.nix` with the package definition
3. Add `default.nix` with NixOS/Home Manager module
4. Update the main `flake.nix` to include the new package

## Requirements

- Nix 2.4+ (for flake support)
- Home Manager (for user-level configurations)
- NixOS (optional, for system-level configurations)

## License

MIT
