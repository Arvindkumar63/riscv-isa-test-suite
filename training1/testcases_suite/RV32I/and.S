
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 5
test1:
li x6, 1          #6 = 1
li x7, 2          #x7 = 2
add x8, x6, x7    #x8 = x6 + x7 = 3

test2:
li x6, 12345      #x6 = 12345
li x7, 54321      #x7 = 54321
add x8, x6, x7    #x8 = x6 + x7 = 66666

test3:
li x6, 0xABCDEF01  # x6 = 0xABCDEF01
li x7, 0x0         # x7 = 0
add x8, x6, x7    # x8 = x6 + x7 = 0xABCDEF01

test4:
li x6, 0x7FFFFFFF  # x6 = max positive signed int
li x7, 0x7FFFFFFF  # x7 = max positive signed int
add x8, x6, x7    # x8 = overflow expected, result = 0xFFFFFFFE

test5:
li x6, -5         # x6 = -5
li x7, 5          # x7 = 5
add x8, x6, x7    # x8 = x6 + x7 = 0


TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

