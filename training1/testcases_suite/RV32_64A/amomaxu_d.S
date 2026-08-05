#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

li gp, 4

# Test 1: Unsigned max(4, 8) = 8
test1:
    li x1, 4
    la x2, dword1
    amomaxu.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 2: Unsigned max(0x1234, 0xABCD) = 0xABCD
test2:
    li x1, 0x1234
    la x2, dword2
    amomaxu.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 3: Corner case - memory has negative (signed) but large unsigned, max(4, 0xFFFFFFFFFFFFFFFF) = 0xFFFFFFFFFFFFFFFF
test3:
    li x1, 4
    la x2, dword3
    amomaxu.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 4: Corner case - memory zero, value large unsigned
test4:
    li x1, 0xFFFFFFFFFFFFFFFE
    la x2, dword4
    amomaxu.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

# Test 5: Unsigned max(-4, 8) = 4
test5:
    li x1, -4
    la x2, dword1
    amomaxu.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0


TEST_PASSFAIL
RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA

dword1:
  .dword 8 

dword2:
  .dword 0xABCD

dword3:
  .dword 0xFFFFFFFFFFFFFFFF

dword4:
  .dword 0x0000000000000000

RVTEST_DATA_END

