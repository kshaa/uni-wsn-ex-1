{
    description = "EDI Testbed & MansOSe environment";

    inputs = {
        nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
        flakeUtils.url = "github:numtide/flake-utils";
        mansOS.url = "github:edi-riga/MansOS";
        mansOS.flake = false;
    };

    outputs = { self, mansOS, nixpkgs, flakeUtils }:
        flakeUtils.lib.eachDefaultSystem (system:
            let
                pkgs = builtins.trace system nixpkgs.legacyPackages.${system};
                editestbedBin = pkgs.fetchurl {
                    url = "https://makonis.edi.lv/s/jZo77yCmEmrX9fY/download";
                    sha256 = "FEcAv5YXRfNt40Kn6uxi3Y93d6/tLrD+76Wbms80VQw=";
                    executable = true;
                };
                editestbedCli = pkgs.writeScriptBin "edi_testbed_cli" "exec ${editestbedBin} \"$@\"";
            in {
                devShell = pkgs.mkShell {
                    buildInputs = with pkgs; [
                        editestbedCli
                        python3
                    ];

                    shellHook =
                    ''
                        export RED='\033[0;31m'
                        export NC='\033[0m' # No Color
                        export PS1="$RED[nix]$NC $PS1"
                        export MOSROOT="${mansOS}"
                    '';
                }; 
            }
        );
}