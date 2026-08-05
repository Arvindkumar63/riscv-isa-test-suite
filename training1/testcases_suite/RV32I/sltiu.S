
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 5  

//check the different test scenarios of sltiu instructions
test1:
li x6, 1
sltiu x8, x6, 2    # x8 = (x6 < 2 unsigned) = 1

test2:
li x6, 10
sltiu x8, x6, 5    # x8 = (10 < 5 unsigned) = 0

test3:
li x6,-1// bcz Unsigned value of -1 (32-bit) = 4294967295 
sltiu x8, x6, 0    # x8 = (max unsigned < 0) = 0

test4:
li x6,-4  //4294967292=-4
sltiu x8, x6, -2   # x8 = 1

test5:
li x6, 0
sltiu x8, x6, 0    # x8 = 0

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
