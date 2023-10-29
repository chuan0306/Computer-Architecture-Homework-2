.global main
.set SYSEXIT, 93
.set SYSWRITE, 64
.set SYSPRINTFHEX, 31
.set SYSPRINTFINT, 32
.data
    str1: .string "Oringinal Data:"
    str2: .string "\nEncrypted Data:"
    str3: .string "\nDecrypted Data:"
.text
start:
main:
    jal   ra, get_cycles
    mv	  s6, a3
    #li	  a0, 1
    #mv    a2, s6
    #li    a7, 32
    #ecall
    # initial setting
    li    s2, 0x01234567
    li    s3, 0x89abcdef
    li    s4, 0x0
    li    s5, 0x000000aa
    # printf test_data[0~31]
    li	  a0, 1
    mv    a4, s4
    li    a7, SYSPRINTFHEX
    ecall
    # printf test_data[32~63]
    li	  a0, 1
    mv    a4, s5
    li    a7, SYSPRINTFHEX
    ecall
NKG:
    jal CLZ
    add   t0, a5, a6
    li    t1, 32
    bne   a5, t1, else
    j     ct
else:
    sub   t0, t0, a6 
ct:
    sll   s0, s2, t0
    sll   s1, s3, t0
    sub   t0, t1, t0
    srl   t1, s3, t0
    or    s0, s0, t1
Enc:
    xor   s4, s0, s4
    xor   s5, s1, s5
    # printf
    li	  a0, 1
    mv    a4, s4
    li    a7, SYSPRINTFHEX
    ecall
    # printf
    li	  a0, 1
    mv    a4, s5
    li    a7, SYSPRINTFHEX
    ecall
Dec:
    xor   s4, s0, s4
    xor   s5, s1, s5
    # printf
    li	  a0, 1
    mv    a4, s4
    li    a7, SYSPRINTFHEX
    ecall
    # printf
    li	  a0, 1
    mv    a4, s5
    li    a7, SYSPRINTFHEX
    ecall
    j     End
CLZ:
    addi  sp, sp , -4
    sw    ra, 0(sp)
    #mv    t0, s2        # remove, useless
    #mv    t1, s3        # remove, useless
    li    t4, 0x55555555
    li    t5, 0x33333333
    li    t6, 0x0f0f0f0f
    # x |= (x>>1)
    srli  t0, s2, 1
    srli  t1, s3, 1
    or    t0, s2, t0
    or    t1, s3, t1
    # x |= (x>>2)
    srli  t2, t0, 2
    srli  t3, t1, 2
    or    t0, t0, t2
    or    t1, t1, t3
    # x |= (x>>4)
    srli  t2, t0, 4
    srli  t3, t1, 4
    or    t0, t0, t2
    or    t1, t1, t3
    # x |= (x>>8)
    srli  t2, t0, 8
    srli  t3, t1, 8
    or    t0, t0, t2
    or    t1, t1, t3
    # x |= (x>>16)
    srli  t2, t0, 16
    srli  t3, t1, 16
    or    t0, t0, t2
    or    t1, t1, t3
    # x -= ((x>>1)$0x55555555)
    srli  t2, t0, 1
    srli  t3, t1, 1
    and   t2, t2, t4
    and   t3, t3, t4
    sub   t0, t0, t2
    sub   t1, t1, t3
    # x = ((x>>2) & 0x33333333)+(x & 0x33333333)
    srli  t2, t0, 2
    srli  t3, t1, 2
    and   t0, t0, t5
    and   t1, t1, t5
    and   t2, t2, t5
    and   t3, t3, t5
    add   t0, t0, t2
    add   t1, t1, t3
    # x = ((x >> 4) + x) & 0x0f0f0f0f
    srli  t2, t0, 4
    srli  t3, t1, 4
    add   t0, t0, t2
    add   t1, t1, t3
    and   t0, t0, t6
    and   t1, t1, t6
    # x += (x >> 8)
    srli  t2, t0, 8
    srli  t3, t1, 8
    add   t0, t0, t2
    add   t1, t1, t3
    # x += (x >> 16)
    srli  t2, t0, 16
    srli  t3, t1, 16
    add   t0, t0, t2
    add   t1, t1, t3
    # (32 - (x & 0x7f))
    andi  t0, t0, 0x7f
    li    t4, 32
    sub   a5, t4, t0
    andi  t1, t1, 0x7f
    sub   a6, t4, t1
    # restore the ra and jump back to `NKG`
    lw    ra, 0(sp)
    addi  sp, sp, 4
    jr    ra
get_cycles:
    csrr  a1, cycleh
    csrr  a3, cycle
    csrr  a2, cycleh
    bne   a1, a2, get_cycles
    ret	
End:
    jal   ra, get_cycles
    sub   a3, a3, s6
    li	  a0, 1
    mv    a2, a3
    li    a7, 32	
    ecall
    li    a0, 0
    li	  a7, SYSEXIT
    ecall
