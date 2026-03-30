{ pkgs }:

# Fetch the gentle-ai binary from GitHub releases
# Version: 1.15.6
let
  gentle-ai-bin = pkgs.fetchurl {
    url = "https://github.com/Gentleman-Programming/gentle-ai/releases/download/v1.15.6/gentle-ai_1.15.6_linux_amd64.tar.gz";
    sha256 = "9114b6cafe642656be1f3077a258964f357f89b82cfb602445a7475537346c26";
  };
in
pkgs.stdenv.mkDerivation {
  pname = "gentle-ai";
  version = "1.15.6";

  src = gentle-ai-bin;

  nativeBuildInputs = [ pkgs.darwin.autoPatchelfHook pkgs.autoPatchelfHook ];

  installPhase = ''
    mkdir -p $out/bin
    tar -xzf $src
    cp gentle-ai_1.15.6_linux_amd64/gentle-ai $out/bin/
    chmod +x $out/bin/gentle-ai
  '';

  meta = with pkgs.lib; {
    description = "Gentle AI - AI Agents Installer";
    homepage = "https://github.com/Gentleman-Programming/gentle-ai";
    license = licenses.mit;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
