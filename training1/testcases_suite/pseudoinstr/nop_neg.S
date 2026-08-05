#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M

RVTEST_CODE_BEGIN
li gp,4
start:
li x5,-0xabcd1234
li x6, -5
test1:
nop
neg x7,x6
nop
negw x8,x5

TEST_PASSFAIL
RVTEST_CODE_END


RVTEST_DATA_BEGIN
TEST_DATA

RVTEST_DATA_END

