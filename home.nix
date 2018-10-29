{ pkgs, ... }:
let

  haskellPackages = pkgs.haskell.packages.ghc843;

  # Custom Haskell packages
  hiePkgs = import (pkgs.fetchFromGitHub {
    owner = "domenkozar";
    repo = "hie-nix";
    rev = "96af698f0cfefdb4c3375fc199374856b88978dc";
    sha256 = "1ar0h12ysh9wnkgnvhz891lvis6x9s8w3shaakfdkamxvji868qa";
  }) {};

  snack = import (pkgs.fetchFromGitHub {
    owner = "nmattia";
    repo = "snack";
    rev = "6dc8caaec88f9a66ad4f66f396db5d5e58d91064";
    sha256 = "0w6gliidknnyv6jlk8533lvji4v6icsq6y1zywfbj9q1xsqw3mx2";
  });

  # TODO: Make custom derivation for latest shfmt
  # - https://github.com/mvdan/sh/tree/v2.5.1
  # - https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/text/shfmt/default.nix

in {
  home.packages = [
    # Development
    pkgs.gitAndTools.gitFull
    pkgs.gnumake
    pkgs.guile_2_2

    # Shell
    pkgs.ripgrep
    pkgs.jq
    pkgs.bat
    pkgs.screen
    pkgs.shfmt

    # Reading
    pkgs.calibre

    # Editors
    pkgs.vim
    #pkgs.emacs26

    # Haskell
    haskellPackages.stack
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.hoogle
    haskellPackages.stylish-haskell
    haskellPackages.hlint
    haskellPackages.brittany
    haskellPackages.ghcid
    haskellPackages.hasktags

    #hiePkgs.hie84
    #snack.snack-exe
    #haskellPackages.ghc-mod

    # Math
    pkgs.isabelle
    #pkgs.z3

    # LaTeX
    pkgs.texlive.combined.scheme-small

    # Command Line Utilities
    pkgs.xclip
    pkgs.tmux
  ];

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
  };
}
