- The `main_v1.s` file is used to enhance the time and space complexity of `hw1.s` in the V0_a folder.
- The `Makefile` is used to compile the `main_v1.s` into the excutable file `main_v1.elf` by using [rv32emu](https://github.com/sysprog21/rv32emu).
- Performance evaluation
    - The execution time of `main_v1.s` is 130 clock cycles shorter than that of `hw1.s`.
        (measured by [Ripes](https://github.com/mortbopet/Ripes)
    - The text section size of `main_v1.s` is 140 units smaller than that of `hw1.s`.
        (measured by [rv32emu](https://github.com/sysprog21/rv32emu))
