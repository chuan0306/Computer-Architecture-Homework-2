#include <stdio.h>
#include <stdint.h>

extern uint64_t get_cycles();

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

uint16_t count_leading_zeros(uint64_t x)
{
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);
    x |= (x >> 32);

    x -= ((x >> 1) & 0x5555555555555555);
    x = ((x >> 2) & 0x3333333333333333) + (x & 0x3333333333333333);
    x = ((x >> 4) + x) & 0x0f0f0f0f0f0f0f0f;
    x += (x >> 8);
    x += (x >> 16);
    x += (x >> 32);

    return (64 - (x & 0x7f));
}

void decrypt(uint64_t *data, uint64_t key)
{
    uint16_t leading_zeros = count_leading_zeros(key);
    *data ^= (key << leading_zeros);
}

void encrypt(uint64_t *data, uint64_t key)
{
    uint16_t leading_zeros = count_leading_zeros(key);
    *data ^= (key << leading_zeros);
}