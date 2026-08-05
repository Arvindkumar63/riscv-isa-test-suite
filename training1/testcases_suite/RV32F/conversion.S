#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 4  # Test index (optional)

# Test 1: fcvt.w.s → float 7.9 → int 7
test1:
  la x4, val_fp_7_9
  flw f1, 0(x4)
  fcvt.w.s x5, f1


# Test 2: fcvt.wu.s → float 8.2 → unsigned int 8
test2:
  la x4, val_fp_8_2
  flw f1, 0(x4)
  fcvt.wu.s x7, f1


# Test 3: fcvt.s.w → int -5 → float -5.0
test3:
  li x9, -5
  fcvt.s.w f2, x9
  la x10, val_fp_n5
  flw f3, 0(x10)


# Test 4: fcvt.s.wu → unsigned 10 → float 10.0
test4:
  li x13, 10
  fcvt.s.wu f4, x13
  la x14, val_fp_10
  flw f5, 0(x14)
 

  TEST_PASSFAIL


RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

val_fp_7_9:  .float 7.9       # → int 7 (truncated)
val_fp_8_2:  .float 8.2       # → unsigned 8 (truncated)
val_fp_n5:   .float -5.0
val_fp_10:   .float 10.0

TEST_DATA
RVTEST_DATA_END

