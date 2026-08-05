#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

# Test 1: Shift 1 by 1 → should become 2
test1:
    c.li x8, 1          
    c.slli x8, 1         
  

# Test 2: Shift 2 by 2 → should become 8
test2:
    c.li x9, 2           
    c.slli x9, 2         
   

test3:
    c.li x10, -32   #x10 = 0xff80 
    c.slli x10,2     
    

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

