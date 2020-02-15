let
  pkgs = import <nixpkgs> {};

  libPath = pkgs.lib.makeLibraryPath [ 
      pkgs.xlibs.libXext 
      pkgs.xlibs.libX11
      pkgs.xlibs.libXrender
      pkgs.xlibs.libXtst
      pkgs.xlibs.libXi
      pkgs.xlibs.libXcursor
      pkgs.xlibs.libXrandr
      pkgs.xlibs.libXxf86vm
      pkgs.xlibs.libXxf86misc
      pkgs.libGL
      pkgs.openal
      
  ];

in pkgs.stdenv.mkDerivation {
  name = "starsector-shell";

  fixupPhase = ''
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/java 
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/java_vm
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/javaws
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/jcontrol
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/keytool
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/orbd
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/pack200
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/policytool
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/rmid
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/rmiregistry
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/servertool
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/tnameserv
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" jre_linux/bin/unpack200
  '';


  shellHook = ''
   export JRE_HOME=jre_linux/bin
   export JAVA_HOME=jre_linux/bin
   export CLASSPATH=jre_linux/lib
   export PATH=native/linux:jre_linux/bin:jre_linux/lib:$PATH
   export LD_LIBRARY_PATH="${libPath}"
   export TMPDIR=/tmp
  '';

}
