.globl main
.set SYSEXIT, 93
.set SYSWRITE, 64
.set SYSPRINTFHEX, 31
.set SYSPRINTFINT, 32
.data
    str1:  .string  "Original Data:"
    str2:  .string  "\nEncrypted Data:"
    str3:  .string  "\nDecrypted Data:"

.text
start:
    j main
count_leading_zeros:
    addi sp, sp, -20
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)#temporary register
    sw s3, 16(sp)#temporary register
    mv s0, a5 #high key
    mv s1, a6 #low key
    
    srli s2, s0, 1     # Right shift by 1
    or   s0, s0, s2   # Bitwise OR
    
    srli s2, s1, 1     # Right shift by 1
    or   s1, s1, s2   # Bitwise OR
    
    srli s2, s0, 2     # Right shift by 2
    or   s0, s0, s2   # Bitwise OR
    
    srli s2, s1, 2     # Right shift by 2
    or   s1, s1, s2   # Bitwise OR

    srli s2, s0, 4     # Right shift by 4
    or   s0, s0, s2   # Bitwise OR

    srli s2, s1, 4     # Right shift by 4
    or   s1, s1, s2   # Bitwise OR
    
    srli s2, s0, 8     # Right shift by 8
    or   s0, s0, s2   # Bitwise OR
    
    srli s2, s1, 8     # Right shift by 8
    or   s1, s1, s2   # Bitwise OR
    
    srli s2, s0, 16    # Right shift by 16
    or   s0, s0, s2   # Bitwise OR

    srli s2, s1, 16    # Right shift by 16
    or   s1, s1, s2   # Bitwise OR
    
    #x -= ((x >> 1) & 0x55555555);
    srli s2, s0, 1           # Right shift by 1
    li s3, 0x55555555
    and s2, s2, s3  # Apply bitmask 0x55555555
    sub  s0, s0, s2          # Subtract from x
    
    #x -= ((x >> 1) & 0x55555555);
    srli s2, s1, 1           # Right shift by 1
    li s3, 0x55555555
    and s2, s2, s3  # Apply bitmask 0x55555555
    sub  s1, s1, s2          # Subtract from x

    #x = ((x >> 2) & 0x33333333) + (x & 0x33333333);
    srli s2, s0, 2           # Right shift by 2
    li s3, 0x33333333
    and s2, s2, s3  # Apply bitmask 0x33333333
    and s3, s3, s0  # Apply bitmask 0x33333333
    add  s0, s2, s3          # Add the results
    
    #x = ((x >> 2) & 0x33333333) + (x & 0x33333333);
    srli s2, s1, 2           # Right shift by 2
    li s3, 0x33333333
    and s2, s2, s3  # Apply bitmask 0x33333333
    and s3, s3, s1  # Apply bitmask 0x33333333
    add  s1, s2, s3          # Add the results
    
    #x = ((x >> 4) + x) & 0x0f0f0f0f;
    srli s2, s0, 4           # Right shift by 4
    add  s0, s0, s2          # Add the result
    li s3, 0x0f0f0f0f
    and s0, s0, s3
    
    #x = ((x >> 4) + x) & 0x0f0f0f0f;
    srli s2, s1, 4           # Right shift by 4
    add  s1, s1, s2          # Add the result
    li s3, 0x0f0f0f0f
    and s1, s1, s3
    
    #x += (x >> 8);
    srli s2, s0, 8           # Right shift by 8
    add  s0, s0, s2          # Add the result
    
    #x += (x >> 8);
    srli s2, s1, 8           # Right shift by 8
    add  s1, s1, s2          # Add the result
    
    #x += (x >> 16);
    srli s2, s0, 16          # Right shift by 16
    add  s0, s0, s2          # Add the result
    
    #x += (x >> 16);
    srli s2, s1, 16          # Right shift by 16
    add  s1, s1, s2          # Add the result
    
    #return (32 - (x & 0x7f))
    andi  s2, s0, 0x7f      # Apply bitmask 0x7f
    li    s3, 32            # Load immediate value 64
    sub   s0, s3, s2        # Subtract from 64
    
    #return (32 - (x & 0x7f))
    andi  s2, s1, 0x7f      # Apply bitmask 0x7f
    li    s3, 32            # Load immediate value 64
    sub   s1, s3, s2        # Subtract from 64
    
    mv a5, s0 #x
    mv a6, s1 #x
    
    lw    ra,  0(sp)        # restore registers
    lw    s0,  4(sp)
    lw    s1,  8(sp)
    lw    s2,  12(sp)
    lw    s3,  16(sp)
    addi  sp, sp, 20       
    
    jr ra
encrypt:  
    li t0, 0            #leading_zeros
    mv a5, s4           #copy of high key 
    mv a6, s5           #copy of low key
    
    jal count_leading_zeros
    
    add t0, a6, a5
    
    li t3, 32
    bne a5, t3, else1
    j ct1
else1:
    sub t0, t0, a6
    
ct1:
    #data ^= (key << leading_zeros)
    mv a5, s4           #copy of high key 
    mv a6, s5           #copy of low key
    sll a5, a5, t0      #left shift high key 
    sll a6, a6, t0      #left shift low key
    
    li t1, 32
    sub t0, t1, t0 
    
    srl t2, a6, t0
    or a5, a5, t2
    xor s7, s7, a5
    xor s8, s8, a6
    
    #la   a0, str2
    #addi a7,  x0,  4       # print "\nEncrypted Data:"
    #ecall
    
    li	  a0, 1
    mv   a4, s7
    li    a7, SYSPRINTFHEX
    ecall
    
    li	  a0, 1
    mv   a4, s8
    li    a7, SYSPRINTFHEX
    ecall
    
    j decrypt
decrypt:
    li t0, 0            #leading_zeros
    mv a5, s4           #copy of high key 
    mv a6, s5           #copy of low key
    
    jal count_leading_zeros
    
    add t0, a6, a5
    
    li t3, 32
    bne a5, t3, else2
    j ct2
else2:
    sub t0, t0, a6
    
ct2:
    #data ^= (key << leading_zeros)
    mv a5, s4           #copy of high key 
    mv a6, s5           #copy of low key
    sll a5, a5, t0      #left shift high key 
    sll a6, a6, t0      #left shift low key
    
    li t1, 32
    sub t0, t1, t0 
    
    srl t2, a6, t0
    or a5, a5, t2
    xor s7, s7, a5
    xor s8, s8, a6
    
    #la   a0, str3
    #addi a7,  x0,  4       # print "\nEncrypted Data:"
    #ecall
    
    li	  a0, 1
    mv   a4, s7
    li    a7, SYSPRINTFHEX
    ecall
    
    li	  a0, 1
    mv   a4, s8
    li    a7, SYSPRINTFHEX
    ecall
    
    jal   ra, get_cycles
    sub   a3, a3, s6
    li	  a0, 1
    mv    a2, a3
    li    a7, 32	
    ecall
    li    a0, 0
    li	  a7, SYSEXIT
    ecall
main:
    jal   ra, get_cycles
    mv	  s6, a3
    li s4, 0x01234567    #key
    li s5, 0x89ABCDEF    #key
    li s7, 0x00000000    #test
    li s8, 0x000000aa    #test

    #la   a0, str1
    #addi a7,  x0,  4       # print "Original Data:\n"
    #ecall
    
    li	 a0, 1
    mv   a4, s4
    li    a7, SYSPRINTFHEX
    ecall
    
    li   a0, 1
    mv   a4, s5
    li    a7, SYSPRINTFHEX
    ecall

    jal encrypt
get_cycles:
    csrr  a1, cycleh
    csrr  a3, cycle
    csrr  a2, cycleh
    bne   a1, a2, get_cycles
    ret
