#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

li gp, 4

# Test 1: AND with all 1s  (memory should remain unchanged)
test1:
    li x1, 4
    la x2, dword1 #x2=6
    amoand.d x3, x1, (x2)// 4 and 6 = 4
    ld x4, 0(x2) #x4=0x0000000000000004
    addi x5, x1, 0 # x5= 4
    addi x6, x3, 0 # x6=0x0000000000000006

# Test 2: AND with zero (memory should be cleared)
test2:
    li x1, 0
    la x2, dword2 # x2 = 0xFFFFFFFFFFFFFFFF
    amoand.d x3, x1, (x2)
    ld x4, 0(x2) #x4=0x0
    addi x5, x1, 0 #x5=0x0
    addi x6, x3, 0 # x6 = 0xffffffffffffffff

# Test 3: Corner case - alternating bits
test3:
    li x1, 0xAAAAAAAAAAAAAAAA
    la x2, dword3 # x2 = 0xFFFFFFFF00000000

    amoand.d x3, x1, (x2)
    ld x4, 0(x2) #  x4 = 0xaaaaaaaa00000000 
    addi x5, x1, 0 #  x5 = 0xaaaaaaaaaaaaaaaa
    addi x6, x3, 0 # x6 = 0xffffffff00000000

# Test 4: Corner case - memory zero,  all 1s (result should remain 0)
test4:
    li x1, 0xFFFFFFFFFFFFFFFF
    la x2, dword4
    amoand.d x3, x1, (x2)
    ld x4, 0(x2)
    addi x5, x1, 0
    addi x6, x3, 0

TEST_PASSFAIL
RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA

dword1:
  .dword 0x6
dword2:
  .dword 0xFFFFFFFFFFFFFFFF

dword3:
  .dword 0xFFFFFFFF00000000

dword4:
  .dword 0x0000000000000000

RVTEST_DATA_END

