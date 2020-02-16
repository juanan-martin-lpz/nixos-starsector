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



  shellHook = ''
   export JRE_HOME=jre_linux/bin
   export JAVA_HOME=jre_linux/bin
   export CLASSPATH=jre_linux/lib
   export PATH=native/linux:jre_linux/bin:jre_linux/lib:$PATH
   export LD_LIBRARY_PATH="${libPath}"
   export TMPDIR=/tmp
  '';

}
