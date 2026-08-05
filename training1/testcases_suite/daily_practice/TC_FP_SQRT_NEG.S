// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        07-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  TC_FP_SQRT_NEGATIVE
// Description:  Floating-point sqrt of negative number (-4.0)
// Expected: NaN
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64F
RVTEST_CODE_BEGIN

  li gp, 3

test3:
  li x6, -4
  fmv.w.x f0, x6

  fsqrt.s f1, f0

TEST_PASSFAIL

RVTEST_CODE_END


RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

