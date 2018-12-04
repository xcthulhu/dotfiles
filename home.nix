{ pkgs, ... }:
let

  defaultHaskellPackages = pkgs.haskell.packages.ghc843;

  haskellPackages = defaultHaskellPackages.override {
    overrides = new : old : rec {
      ghc-exactprint =
        if (pkgs.stdenv.isDarwin) then
          pkgs.haskell.lib.dontCheck old.ghc-exactprint
        else
          old.ghc-exactprint;
    };
  };

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

in {
  home.packages = [
    ## Development
    pkgs.gitAndTools.gitFull
    pkgs.mercurial
    pkgs.gnumake
    pkgs.guile_2_2

    ## Database
    pkgs.postgresql
    pkgs.flyway
    pkgs.pg_tmp

    ## Python
    pkgs.python36
    pkgs.python36Packages.virtualenv
    pkgs.python36Packages.ipython

    ## Shell
    pkgs.ripgrep
    pkgs.jq
    pkgs.tmux
    pkgs.screen
    pkgs.shfmt
    pkgs.shellcheck
    pkgs.bat

    ## Editors
    pkgs.vim
    #pkgs.emacs26

    ## Haskell
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.stylish-haskell
    haskellPackages.hlint
    haskellPackages.brittany
    haskellPackages.ghcid
    haskellPackages.hasktags

    #hiePkgs.hie84
    #snack.snack-exe
    #haskellPackages.ghc-mod

    ## Math
    pkgs.z3

    ## LaTeX
    pkgs.texlive.combined.scheme-small
    ]
    ++ (if (pkgs.stdenv.isLinux) then [
      ## Linux only packages
      ## Reading
      pkgs.calibre

      ## Haskell
      haskellPackages.stack

      ## Command Line Utilities
      pkgs.xclip
      ] else []);

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
  };
}
