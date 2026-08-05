#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

li gp, 4

# Test 1: Simple - max(4, 6) = 6
test1:
    li x1, 4
    la x2, dword1
    amomax.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 2: Simple - max(0x1234, 0xABCD) = 0xABCD
test2:
    li x1, 0x1234
    la x2, dword2
    amomax.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 3: Corner case - max(negative, positive) = positive
test3:
    li x1, -5
    la x2, dword3
    amomax.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 4: Corner case - max(positive, negative) = positive
test4:
    li x1, 0x7FFFFFFFFFFFFFFF
    la x2, dword4
    amomax.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

TEST_PASSFAIL
RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA

dword1:
  .dword 6

dword2:
  .dword 0xABCD

dword3:
  .dword 123

dword4:
  .dword -999999999

RVTEST_DATA_END

