#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 1     

# ---------------------------
# Test 1: FMV.X.W — float to int (bit pattern preserved)
test1:
  la x4, val_1_5
  flw f1, 0(x4)             # Load 1.5 (0x3FC00000) into f1
  fmv.x.w x5, f1            # Move bits to x5

 

  TEST_PASSFAIL



RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

val_1_5:  .float 1.5

TEST_DATA
RVTEST_DATA_END

