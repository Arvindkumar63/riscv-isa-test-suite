#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 5  

test1: # Multiply by 8 using shift
li x6, 6
li x7, 3
sll x8, x6, x7    # x8 = 6 << 3 = 48

test2: # Divide unsigned by 4 using srl
li x6, 200
li x7, 2
srl x8, x6, x7    # x8 = 200 >> 2 = 50

test3: # Divide signed by 2 using sra
li x6, -40
li x7, 1
sra x8, x6, x7    # x8 = -20 = 0xffffffffffffffec


test4: # Divide signed by 2 using srl but not giving correct answer
li x6, -40
li x7, 1
srl x8, x6, x7    # x8 =0x7fffffffffffffec

testa4: # Divide unsigned value by 2^(-2) using sra
li x6, 40
li x7, -2
sra x8, x6, x7    # x8 =0x0000000000000000

test5: # Multiply by 10: (x << 3) + (x << 1)
li x6, 7
sll x7, x6, 3     # x7 = x6 * 8
sll x8, x6, 1     # x8 = x6 * 2
add x8, x7, x8    # x8 = x6 * 10 = 70



test6: # Sign check using sra
li x6,-3
li x7, 31
sra x8, x6, x7    # x8 = -1

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

