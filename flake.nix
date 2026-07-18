{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    creamlinux-installer = {
      url = "github:Novattz/creamlinux-installer?rev=7c16b63b41f984a1f480fa14ce78da4cc4869a66";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      sops-nix,
      nix-flatpak,
      home-manager,
      ...
    }@inputs:
    let
      host = "AKATOSH"; # Maps to configuration in hosts/
      users = [ "peach" ]; # Maps to configurations in users/

      hostConfig = import ./hosts/${host};
      architecture = hostConfig.meta.architecture;
      hostName = hostConfig.meta.hostName;

      mainConfig =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          imports = [
            ./configuration.nix
            hostConfig.module
          ]
          ++ (map (user: ./users/${user}.nix) users);
        };
    in
    {
      formatter.${architecture} = nixpkgs.legacyPackages.${architecture}.nixfmt-tree;
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        system = architecture;
        modules = [
          mainConfig
          sops-nix.nixosModules.sops
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
              sops-nix.homeManagerModules.sops
              nix-flatpak.homeManagerModules.nix-flatpak
            ];
          }
        ];
      };
    };
}
