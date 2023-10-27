.PHONY: clean

include ../../../rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
CROSS_COMPILE = riscv-none-elf-gcc

all: hw1.elf

hw1.elf: hw1.s
	$(CROSS_COMPILE) -o hw1.elf hw1.s

clean:
	$(RM) main.elf main.o
