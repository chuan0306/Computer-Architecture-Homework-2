#include <stdio.h>
#include <stdint.h>
#include "clz.c"
#include "encrypt.c"
#include "decrypt.c"

extern uint64_t get_cycles();
extern uint64_t get_instret();
// extern void sparkle_asm(unsigned int *state, unsigned int ns);

#define WORDS 12
#define ROUNDS 7

int main()
{
    unsigned int state[WORDS] = {0};
    // measure cycles
    uint64_t instret = get_instret();
    uint64_t oldcount = get_cycles();
    

    uint64_t key = 0x0123456789ABCDEF; // Encryption key
    uint64_t test_data = 0x0000000010101010; // Test data in binary

    printf("Original Data:\n");
    printf("Data: 0x%016lx\n", test_data);

    /* Encrypt and print encrypted data */
    printf("\nEncrypted Data:\n");
    encrypt(&test_data, key);
    printf("Data: 0x%016lx\n", test_data);

    /* Decrypt and print decrypted data */
    printf("\nDecrypted Data:\n");
    decrypt(&test_data, key);
    printf("Data: 0x%016lx\n", test_data);
    
    // sparkle_asm(state, ROUNDS);
    uint64_t cyclecount = get_cycles() - oldcount;
    printf("cycle count: %u\n", (unsigned int) cyclecount);
    printf("instret: %x\n", (unsigned) (instret & 0xffffffff));
    memset(state, 0, WORDS * sizeof(uint32_t));
    // sparkle_asm(state, ROUNDS);

    return 0;
}