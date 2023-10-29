.PHONY: clean

include ~/rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
CROSS_COMPILE = riscv-none-elf-gcc

all: main.elf

main.elf: getcycles.o main.o
	$(CROSS_COMPILE) -o main.elf getcycles.o  main.o

%.o: %.c
	$(CROSS_COMPILE) $(ASFLAGS) -c -o $@ $<

%.o: %.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o $@ $<

clean:
	$(RM) main.elf main.o getcycles.o