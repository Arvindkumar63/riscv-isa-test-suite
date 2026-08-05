#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M

RVTEST_CODE_BEGIN
li x6, 5
test1:
nop
sgtz x7,x6


TEST_PASSFAIL
RVTEST_CODE_END


RVTEST_DATA_BEGIN
TEST_DATA

RVTEST_DATA_END


