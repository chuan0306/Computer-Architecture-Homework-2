.PHONY: clean

include ../../mk/toolchain.mk

ASFLAGS = -march=rv32i -mabi=ilp32
LDFLAGS = --oformat=elf32-littleriscv

OBJECT = main.o clz.o decrypt.p encrypt.o getcycles.o getinstret.o sparkle.o ticks.o

main.elf: $(OBJECT)
	

%.o: %.s
	$(CROSS_COMPILE)as -R $(ASFLAGS) -o $@ $<

all: hw.elf32

hello.elf: hello.oformat
	$(CROSS_COMPILE)ld -o $@ -T hello.ld $(LDFLAGS) $<

clean:
	$(RM) hello.elf hello.o