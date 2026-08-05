#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
    li x5,-5 
    li x6, 10
	 bgeu x5, x6, label1
    li x7, 11      # skipped
label1:
    li x8, 22

test2:
    li x5,10
	 li x6,-5
	 bgeu x5, x6, label2
    li x9, 33      # should execute
label2:
    li x10, 44



TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

