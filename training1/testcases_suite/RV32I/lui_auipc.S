


#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 5
//test lui 
test1:
    lui x5, 0x12345//x5 = 0x12345000 (x5 << 12)
    li  x6, 0x12345000
    beq x5, x6, pass1
pass1:
li x7,1
// test AUIPC (Add Upper Immediate to PC)
test2:
auipc x8,0x1//x9 = PC + (1 << 12)
addi x9,x8,10


TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END


