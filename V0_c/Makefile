.PHONY: clean

include ~/rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
CROSS_COMPILE = riscv-none-elf-gcc

all: main.elf

main.elf: getcycles.o main.o
	$(CROSS_COMPILE) -o main.elf getcycles.o main.o

%.o: %.c
	$(CROSS_COMPILE) $(ASFLAGS) -c -o $@ $<

%.o: %.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o $@ $<

#getcycles.o: getcycles.s
#	$(CROSS_COMPILE) $(ASFLAGS) -c -o getcycles.o getcycles.s
		
#main.o: main.s
#	$(CROSS_COMPILE) $(ASFLAGS) -c -o main.o main.s

#main.s: main.c
#	$(CROSS_COMPILE) $(ASFLAGS) -s -o main.s main.c

clean:
	$(RM) main.elf main.o main.s getcycles.o
