{
  description = "SDR related Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in
  {
    packages.${system} = {
      rtpmidid = pkgs.stdenv.mkDerivation {
        pname = "rtpmidid";
        version = "dev";
        src = "${self}";

        nativeBuildInputs = with pkgs; [
          cmake
          pkgconfig
        ];

        buildInputs = with pkgs; [
          avahi
          fmt
          alsa-lib
        ];  

        installPhase = ''
          mkdir -p $out/bin
          install -D src/rtpmidid $out/bin/
        '';
      };
      default = self.packages.${system}.rtpmidid;
    };
  };
}