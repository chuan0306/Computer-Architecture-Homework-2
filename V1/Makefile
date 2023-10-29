.PHONY: clean

include ../../../rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
CROSS_COMPILE = riscv-none-elf-

all: main_v1.elf

main_v1.elf: main_v1.o
	$(CROSS_COMPILE)ld -o main_v1.elf main_v1.o
	
%.o: %.s
	$(CROSS_COMPILE)as -R $(ASFLAGS) -o $@ $<

clean:
	$(RM) main_v1.elf main_v1.o
