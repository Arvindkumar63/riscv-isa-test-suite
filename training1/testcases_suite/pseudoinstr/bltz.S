#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M

RVTEST_CODE_BEGIN
li gp,4
start:
la x5,label1
test1:
li x6,44
bltz x6,label1 #not taken branch
addi x8,x6,6

label1:
addi x8,x6,-4

TEST_PASSFAIL
RVTEST_CODE_END


RVTEST_DATA_BEGIN
TEST_DATA

RVTEST_DATA_END

