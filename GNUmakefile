A="/c/Program Files/AMD APP"
LLVMBIN=/c/cygwin/home/nakamura/llvm/build/mingw-static/Release+Asserts/bin
CC=$(LLVMBIN)/clang.exe
I=-I $A
CFLAGS=-O3 -Wall $I/include
LDFLAGS=-L $A/lib/x86
LDLIBS=-lOpenCL

.PRECIOUS: %.bc %.ll %.s %.link.ll %.lopt.ll

%.exe: %.s
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.bc: %.c
	$(CC) -MMD $(CFLAGS) $< -o $@ -emit-llvm

%.ll: %.c
	$(CC) -MMD $(CFLAGS) $< -o $@ -emit-llvm -S

%.s: %.ll
	$(LLVMBIN)/llc -regalloc=pbqp $< -o $@

%.link.bc: %.ll
	$(LLVMBIN)/llvm-link -o $@ $^

%.lopt.ll: %.link.bc
	$(LLVMBIN)/opt -stats -std-link-opts $< -o $@

gty.lopt.exe: gty.lopt.s
gty.link.bc: gty.ll sha1_32.ll

-include *.d

#EOF
