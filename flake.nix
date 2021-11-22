{
  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs"; };

    devShell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = { url = "github:numtide/flake-utils"; };
  };
  outputs = { self, nixpkgs, devShell, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devShell.overlay ];
        };
      in {
        devShell =
          pkgs.devshell.mkShell { commands = [{ package = pkgs.hugo; }]; };
      });

}
