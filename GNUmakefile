A="/c/Program Files/AMD APP"
B="/c/Program Files (x86)/AMD APP"
LLVMBIN=/c/cygwin/home/nakamura/llvm/build/mingw-static/Release+Asserts/bin
CC=$(LLVMBIN)/clang
CXX=$(LLVMBIN)/clang++
I=-isystem $A -isystem $B
CFLAGS=-O3 -Wall $I/include
CXXFLAGS=$(CFLAGS)
LDFLAGS=-L $A/lib/x86 -L $B/lib/x86
LDLIBS=-lOpenCL

.PRECIOUS: %.c %.bc %.ll %.s %.link.ll %.lopt.ll

%.exe: %.s
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.bc: %.c
	$(CC) -MMD $(CFLAGS) $< -o $@ -emit-llvm

%.ll: %.c
	$(CC) -MMD $(CFLAGS) $< -o $@ -emit-llvm -S

%.bc: %.cpp
	$(CXX) -MMD $(CXXFLAGS) $< -o $@ -emit-llvm

%.ll: %.cpp
	$(CXX) -MMD $(CXXFLAGS) $< -o $@ -emit-llvm -S

%.s: %.ll
	$(LLVMBIN)/llc -regalloc=pbqp $< -o $@

%.link.bc: %.ll
	$(LLVMBIN)/llvm-link -o $@ $^

%.lopt.ll: %.link.bc
	$(LLVMBIN)/opt -stats -std-link-opts $< -o $@

%.c: %.y
	bison -o $@ $<

%.c: %.lex
	flex -o$@ -v $<

gty.lopt.exe: gty.lopt.s
gty.link.bc: gty.ll #expr_parse.ll synth.ll wdict.ll

-include *.d

#EOF
