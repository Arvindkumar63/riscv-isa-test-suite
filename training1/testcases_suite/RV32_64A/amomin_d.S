#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

li gp, 4

# Test 1: Signed min(4, 6) = 4
test1:
    li x1, 4
    la x2, dword1
    amomin.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 2: Signed min(-5, 3) = -5
test2:
    li x1, -5
    la x2, dword2
    amomin.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 3: Corner case - min(-1, 0x7FFFFFFFFFFFFFFF) = -1
test3:
    li x1, -1
    la x2, dword3
    amomin.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 4: Corner case - memory is min, new is max
test4:
    li x1, 0x7FFFFFFFFFFFFFFF
    la x2, dword4
    amomin.d x3, x1, (x2)
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
  .dword 3

dword3:
  .dword 0x7FFFFFFFFFFFFFFF

dword4:
  .dword -9223372036854775808  # 0x8000000000000000

RVTEST_DATA_END

