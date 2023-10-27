.PHONY: clean

include ../../../rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
#ASFLAGS = -march=rv32i -mabi=ilp32 -Wall
CROSS_COMPILE = riscv-none-elf-gcc

all: main_v1.elf

main_v1.elf: main_v1.s
	$(CROSS_COMPILE) -o main_v1.elf main_v1.s
	
#main_v1.o: main_v1.s
#	$(CROSS_COMPILE) $(ASFLAGS) -c -o main_v1.o main_v1.s

clean:
	$(RM) main.elf main.o
