#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 3

# Test 1: Simple c.jalr to x1
test1:
    la x1, label1
    c.jalr x1
   c.li x5, 1  # should not execute
label1:
    c.li x6, 3

TEST_PASSFAIL
RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END

