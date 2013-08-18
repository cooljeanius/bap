VEX_DIR=/Users/ericgallager/GitHubReposFromOtherComputers/bap/VEX
LIBASMIR_CXXFLAGS=-I/Users/ericgallager/GitHubReposFromOtherComputers/bap/VEX/pub -I/Users/ericgallager/GitHubReposFromOtherComputers/bap/src/include -g -O2
LIBASMIR_LDFLAGS=-L/Users/ericgallager/GitHubReposFromOtherComputers/bap/VEX -L/Users/ericgallager/GitHubReposFromOtherComputers/bap/src -L/Users/ericgallager/build/lib -L/sw/opt/kde4/x11/lib -L/sw/lib/freetype219/lib -L/sw/lib/fontconfig2/lib -L/sw/lib/qt4-x11/lib -L/sw/opt/qca2/x11/lib  -Wl,-dylib_file,/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib:/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib -Wl,-dead_strip_dylibs
LIBASMIR_LIBS=-lasmir -lvex -lbfd -ldl -liberty -lz
CLIBS=asmir vex opcodes bfd z iberty stdc++
