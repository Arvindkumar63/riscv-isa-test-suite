#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M

RVTEST_CODE_BEGIN
li gp,4
start:
li x5,8
test1:
nop
snez x8,x5

TEST_PASSFAIL
RVTEST_CODE_END


RVTEST_DATA_BEGIN
TEST_DATA

RVTEST_DATA_END


