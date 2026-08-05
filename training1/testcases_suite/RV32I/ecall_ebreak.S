#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 1

test1: 
//ECALL instruction (environment call) 

li x5, 100
ecall      // Triggers environment call 
addi x6, x5, 20   // Should be skipped

test2:
// EBREAK instruction (debug breakpoint)

li x7, 200
ebreak   // Triggers debug exception (breakpoint)
addi x8, x7, 40   // Should also be skipped if ebreak traps

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
