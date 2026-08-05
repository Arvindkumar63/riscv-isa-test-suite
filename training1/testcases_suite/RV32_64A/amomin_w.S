#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

li gp, 4

# Test 1: Signed min(10, 20) = 10
test1:
    li x1, 10
    la x2, word1
    amomin.w x3, x1, (x2)
    lw x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 2: Signed min(-15, 5) = -15
test2:
    li x1, -15
    la x2, word2
    amomin.w x3, x1, (x2)
    lw x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 3: Corner case - min(-1, 0x7FFFFFFF) = -1
test3:
    li x1, -1
    la x2, word3
    amomin.w x3, x1, (x2)
    lw x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 4: Corner case - memory is INT_MIN
test4:
    li x1, 0x7FFFFFFF
    la x2, word4
    amomin.w x3, x1, (x2)
    lw x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

TEST_PASSFAIL
RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA

word1:
  .word 20

word2:
  .word 5

word3:
  .word 0x7FFFFFFF

word4:
  .word -2147483648  # 0x80000000

RVTEST_DATA_END

