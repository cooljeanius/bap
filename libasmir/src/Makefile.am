## automake Makefile for libasmir sources

DISTCLEANFILES = .DS_Store

RANLIB = @RANLIB@
lib_LIBRARIES = libasmir.a
#lib_LTLIBRARIES = libasmir.la
AM_CFLAGS = ${acl_cv_wp}-I@VEX_DIR@/pub ${acl_cv_wp}-I../include \
  ${acl_cv_wp}-Itraces -fPIC -DGET_OPERANDS
AM_CXXFLAGS = $(AM_CFLAGS)

if GCC
VEX_MAKEFILE = -f Makefile-gcc
endif

libasmir_a_SOURCES = \
	./old_ir/stmt.cpp \
	./old_ir/stmt_c.cpp \
	./old_ir/exp.cpp \
	./old_ir/exp_c.cpp \
	asm_program.c \
	symbols.c \
	memory_data.cpp \
	irtoir_c.cpp \
	irtoir.cpp \
	irtoir-i386.cpp \
	irtoir-arm.cpp \
	vexir.c \
	vexmem.c \
	ocaml_helpers.c \
	llvm.cpp \
	./traces/readtrace.cpp \
	./traces/trace.cpp \
	./traces/trace_v40.cpp \
	./traces/trace_v41.cpp \
	./traces/trace_v50.cpp \
	./traces/reg_mapping.cpp \
	./traces/reg_mapping_pin.cpp \
        ./traces/pin_frame.h ./traces/pin_frame.cpp \
        ./traces/pin_trace.h ./traces/pin_trace.cpp
libasmir_a_LIBADD = @VEX_DIR@/libvex.a @BAP_DIR@/libtracewrap/libtrace/src/cpp/libtrace.a

@VEX_DIR@/libvex.a: @VEX_DIR@/Makefile
	$(MAKE) -C @VEX_DIR@ $(VEX_MAKEFILE) libvex.a CC=$(CC)

@BAP_DIR@/libtracewrap/libtrace/src/cpp/libtrace.a: @BAP_DIR@/libtracewrap/libtrace/src/cpp/Makefile
	$(MAKE) -C @BAP_DIR@/libtracewrap/libtrace/src/cpp libtrace.a
