.PHONY: clean

include ../../../rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall

#CROSS_COMPILE = riscv-none-elf-

all: main_v2.elf

main_v2.elf: main_v2.o
	$(CROSS_COMPILE)ld -o $@ -T main_v2.ld $(LDFLAGS) $<

%.o: %.s
	$(CROSS_COMPILE)as -R $(ASFLAGS) -o $@ $<

#main_v1.o: main_v1.s
#	$(CROSS_COMPILE)as -R $(ASFLAGS) -o $@ $<

clean:
	$(RM) main_v2.elf main_v2.o
