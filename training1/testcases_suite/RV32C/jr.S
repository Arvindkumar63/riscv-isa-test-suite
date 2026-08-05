#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN


test1:
la x2, label1
c.li x8,10

 c.jr x2
 c.addi x8,20


 label1:
    c.addi x12, 10 


TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END


