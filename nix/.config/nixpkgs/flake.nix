{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    bleeding.url = "github:nixos/nixpkgs/master"; # same as stable, but updated more often
    homeManager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stable.url = "nixpkgs/nixos-21.11";
    rock.url = "nixpkgs/nixos-21.11"; # not updated often
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    personal = {
      url = "path:/home/meain/dev/src/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacsOverlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tree-grepper = {
      url = "github:BrianHicks/tree-grepper";
    };
  };

  outputs =
    { self
    , nixpkgs
    , homeManager
    , stable
    , rock
    , bleeding
    , nur
    , personal
    , emacsOverlay
    , tree-grepper
    }: {
      homeConfigurations =
        let
          homeConfig = import ./home.nix {
            inherit stable rock personal bleeding tree-grepper;
          };
        in
        {
          meain = homeManager.lib.homeManagerConfiguration {
            modules = [
              homeConfig
            ];

            pkgs = import nixpkgs {
              system = "x86_64-linux";
              overlays = [ emacsOverlay.overlay nur.overlay ];
            };
          };
        };
    };
}
