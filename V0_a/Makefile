.PHONY: clean

include ../../../rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
CROSS_COMPILE = riscv-none-elf-

all: hw1.elf

hw1.elf: hw1.o
	$(CROSS_COMPILE)ld -o hw1.elf hw1.o

hw1.o: hw1.s
	$(CROSS_COMPILE)as -R $(ASFLAGS) -o $@ $<

clean:
	$(RM) main.elf main.o
