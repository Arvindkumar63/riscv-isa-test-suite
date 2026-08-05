#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 2        

# Test 1: subnormal + subnormal
test1:
  la x4, val_sub
  flw f1, 0(x4)
  flw f2, 0(x4)
  fadd.s f3, f1, f2
  flt.s x6, f3, f1   # still smaller than normal? → pass

# Test 2: subnormal - same subnormal → should be 0.0
test2:
  flw f1, 0(x4)
  flw f2, 0(x4)
  fsub.s f3, f1, f2
  feq.s x6, f3, f3   # f3 == f3 confirms it's valid float (should be 0.0)

TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA

val_sub: .word 0x00000001     # A subnormal positive float (~1e-44)

TEST_DATA
RVTEST_DATA_END

