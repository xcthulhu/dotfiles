{ pkgs, ... }:
let

  defaultHaskellPackages = pkgs.haskell.packages.ghc863;

  haskellPackages = defaultHaskellPackages.override {
    overrides = new : old : rec {
      ghc-exactprint =
        if (pkgs.stdenv.isDarwin) then
          pkgs.haskell.lib.dontCheck old.ghc-exactprint
        else
          old.ghc-exactprint;
    };
  };

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
    pkgs.sqlite

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
    pkgs.unrar
    pkgs.rlwrap

    ## Networking
    pkgs.inetutils # ifconfig, ftp, etc

    ## Editors
    pkgs.vim

    ## Haskell
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.stylish-haskell
    haskellPackages.hlint
    #haskellPackages.brittany
    haskellPackages.ghcid
    haskellPackages.hasktags
    haskellPackages.hoogle

    #hiePkgs.hie84
    #snack.snack-exe
    #haskellPackages.ghc-mod

    ## Math
    pkgs.z3

    ## LaTeX
    pkgs.texlive.combined.scheme-full
    ]
    ++ (if (pkgs.stdenv.isLinux) then [
      ## Linux only packages
      ## Reading
      pkgs.calibre

      ## Haskell
      haskellPackages.stack

      ## Command Line Utilities
      pkgs.xclip

      ## Windows Emulator
      pkgs.wine
      ] else []);

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
  };
}
