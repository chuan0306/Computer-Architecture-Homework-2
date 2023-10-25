.PHONY: clean

include ../rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
CROSS_COMPILE = riscv-none-elf-gcc

all: main.elf

main.elf: getcycles.o getinstret.o main.o
	$(CROSS_COMPILE) -o main.elf getcycles.o getinstret.o main.o

getcycles.o: getcycles.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o getcycles.o getcycles.s
	
getinstret.o: getinstret.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o getinstret.o getinstret.s
	
main.o: main.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o main.o main.s

main.s: main.c
	$(CROSS_COMPILE) $(ASFLAGS) -S -o main.s main.c

clean:
	$(RM) main.elf main.o
