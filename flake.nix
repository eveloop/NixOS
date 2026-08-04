{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      self,
      nixpkgs,
      sops-nix,
      nix-flatpak,
      home-manager,
      ...
    }@inputs:
    let
      hosts = {
        AKATOSH = {
          system = "x86_64-linux";
          users.peach = [ "full" ];
        };
      };

      mkHost =
        hostName:
        { system, users }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./hosts/${hostName}
            sops-nix.nixosModules.sops
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                sharedModules = [
                  sops-nix.homeManagerModules.sops
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            }
          ]
          ++ (nixpkgs.lib.mapAttrsToList (
            user: profiles: import ./users/${user}.nix { inherit profiles; }
          ) users);
        };

      supportedSystems = nixpkgs.lib.unique (map (host: host.system) (builtins.attrValues hosts));
      pkgsFor = system: nixpkgs.legacyPackages.${system};

      lintChecks =
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          formatting = pkgs.runCommand "check-formatting" { nativeBuildInputs = [ pkgs.nixfmt-tree ]; } ''
            cp -r ${self} src && chmod -R u+w src && cd src
            treefmt --fail-on-change --no-cache
            touch $out
          '';
          statix = pkgs.runCommand "check-statix" { nativeBuildInputs = [ pkgs.statix ]; } ''
            cp -r ${self} src && chmod -R u+w src && cd src
            statix check -i "hosts/*/hardware-configuration.nix" .
            touch $out
          '';
          deadnix = pkgs.runCommand "check-deadnix" { nativeBuildInputs = [ pkgs.deadnix ]; } ''
            cp -r ${self} src && chmod -R u+w src && cd src
            deadnix --fail --exclude "*/hardware-configuration.nix" .
            touch $out
          '';
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hosts;

      checks = nixpkgs.lib.foldl' nixpkgs.lib.recursiveUpdate { } (
        map (hostName: {
          ${hosts.${hostName}.system}."host-${hostName}" =
            self.nixosConfigurations.${hostName}.config.system.build.toplevel;
        }) (builtins.attrNames hosts)
        ++ map (system: { ${system} = lintChecks system; }) supportedSystems
      );

      formatter = nixpkgs.lib.genAttrs supportedSystems (system: (pkgsFor system).nixfmt-tree);

      devShells = nixpkgs.lib.genAttrs supportedSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              pkgs.sops
              pkgs.age
              pkgs.ssh-to-age
              pkgs.statix
              pkgs.deadnix
              pkgs.nixfmt-tree
              pkgs.nil
            ];
          };
        }
      );
    };
}
