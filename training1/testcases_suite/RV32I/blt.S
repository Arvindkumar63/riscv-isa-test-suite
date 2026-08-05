#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
    li x5, 10
    li x6, 15 
    li x7, 0

    blt x5, x6, equal
    li x7, 1          # Not taken if x5 == x6

equal:
        li x7, 2

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END


