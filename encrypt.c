#include <stdint.h>
void encrypt(uint64_t *data, uint64_t key)
{
    uint16_t leading_zeros = count_leading_zeros(key);
    *data ^= (key << leading_zeros);
}