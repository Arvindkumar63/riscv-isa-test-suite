#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M

RVTEST_CODE_BEGIN
li gp,4
start:
la x5,label1
# Test1: x6 is greater than 0 → branch taken
test1:
li x6,3
bgtz x6,label
addi x9,x6,2

label:
addi x9,x9,-1

# Test2: x6 is zero → not greater than zero → branch not taken
test2:
li x6,0
bgtz x6,label1
addi x8,x6,3

label1:
addi x8,x8,1

# Test3: x6 is negative → branch not taken
test3:
li x6,-5
bgtz x6,label2
addi x9,x6,2

label2:
addi x9,x9,-1

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END

