VEX_DIR=/var/root/bap/VEX
LIBASMIR_CXXFLAGS=-I/var/root/bap/VEX/pub -I/var/root/bap/src/include -g -O2
LIBASMIR_LDFLAGS=-L/var/root/bap/VEX -L/var/root/bap/src -L/opt/local/lib -L/opt/local/lib/x86_64/
LIBASMIR_LIBS=-lasmir -lvex -lbfd -ldl -liberty -lz
CLIBS=asmir vex opcodes bfd z iberty stdc++
