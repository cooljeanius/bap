VEX_DIR=/private/var/root/Downloads/bap-0.7/VEX
LIBASMIR_CXXFLAGS=-I/private/var/root/Downloads/bap-0.7/VEX/pub -I/private/var/root/Downloads/bap-0.7/src/include -g -O2
LIBASMIR_LDFLAGS=-L/private/var/root/Downloads/bap-0.7/VEX -L/private/var/root/Downloads/bap-0.7/src -L/opt/local/lib -L/opt/local/lib/x86_64/
LIBASMIR_LIBS=-lasmir -lvex -lbfd -ldl -liberty -lz
CLIBS=asmir vex opcodes bfd z iberty stdc++
