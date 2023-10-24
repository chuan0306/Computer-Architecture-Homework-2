.PHONY: clean

include ../../mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32  -Wall
# LDFLAGS = --oformat=elf32-littleriscv
TMP = riscv-none-elf-gcc
%.s: %.c
	$(TMP) $(ASFLAGS) -s -o $@ $<

%.o: %.s
	$(TMP) $(ASFLAGS) -c -o  $@ $<

all: main.elf32

main.elf: hello.oformat
	$(TMP)ld -o $@ -T hello.ld $<

clean:
	$(RM) main.elf main.o
