LLVMBIN=/c/cygwin/home/nakamura/llvm/build/mingw-static/Release+Asserts/bin
CC=$(LLVMBIN)/clang.exe
CFLAGS=-O3 -Wall

.PRECIOUS: %.bc %.ll %.s %.link.ll %.lopt.ll

%.exe: %.s
	$(CC) -o $@ $^

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
