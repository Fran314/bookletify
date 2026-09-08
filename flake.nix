{
  description = "Rearrange the pages of a pdf so it can be printed and bound as a booklet";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      bookletify = pkgs.callPackage ./. { };
    in
    {
      packages.${system}.default = bookletify;

      apps.${system}.default = {
        type = "app";
        program = "${bookletify}/bin/bookletify";
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (ps: [ ps.pypdf ]))
          pkgs.python3Packages.flake8
        ];
      };
    };
}
