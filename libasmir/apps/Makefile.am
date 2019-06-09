## automake Makefile for libasmir apps

bin_PROGRAMS = \
	print-ir \
	lifttrace

# these executables should depend on libasmir, since they link it in
# statically.
print_ir_DEPENDENCIES = ../src/libasmir.a
lifttrace_DEPENDENCIES = ../src/libasmir.a

print_ir_SOURCES = print-ir.cpp ir_printer.cpp
lifttrace_SOURCES = lifttrace.cpp
LDADD = @ASMIR_DIR@/src/libasmir.a @VEX_DIR@/libvex.a -lbfd -ldl -lopcodes
AM_CXXFLAGS = \
              ${acl_cv_wp}-I../include \
              ${acl_cv_wp}-I../src/traces \
              ${acl_cv_wp}-I@VEX_DIR@/pub

