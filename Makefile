.PHONY: clean

include ../rv32emu/mk/toolchain.mk

ASFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall
# LDFLAGS = --oformat=elf32-littleriscv
CROSS_COMPILE = riscv-none-elf-gcc

all: main.elf

main.elf: clz.o decrypt.o encrypt.o ticks.o getcycles.o getinstret.o main.o
	$(CROSS_COMPILE) -o main.elf clz.o decrypt.o encrypt.o ticks.o getcycles.o getinstret.o main.o

clz.o: clz.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o clz.o clz.s

decrypt.o: decrypt.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o decrypt.o decrypt.s
	
encrypt.o: encrypt.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o encrypt.o encrypt.s
	
ticks.o: ticks.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o ticks.o ticks.s
	
getcycles.o: getcycles.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o getcycles.o getcycles.s
	
getinstret.o: getinstret.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o getinstret.o getinstret.s
	
main.o: main.s
	$(CROSS_COMPILE) $(ASFLAGS) -c -o main.o main.s

clz.s: clz.c
	$(CROSS_COMPILE) $(ASFLAGS) -S -o clz.s clz.c

decrypt.s: decrypt.c
	$(CROSS_COMPILE) $(ASFLAGS) -S -o decrypt.s decrypt.c

encrypt.s: encrypt.c
	$(CROSS_COMPILE) $(ASFLAGS) -S -o encrypt.s encrypt.c
	
ticks.s: ticks.c
	$(CROSS_COMPILE) $(ASFLAGS) -S -o ticks.s ticks.c
	
main.s: main.c
	$(CROSS_COMPILE) $(ASFLAGS) -S -o main.s main.c

clean:
	$(RM) main.elf main.o
#%.s: %.c
#	$(CROSS_COMPILE) $(ASFLAGS) -s -o $@ $<

#%.o: %.s
#	$(CROSS_COMPILE) $(ASFLAGS) -c -o  $@ $<
