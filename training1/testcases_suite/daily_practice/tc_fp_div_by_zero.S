// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        07-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  TC_FP_DIV_BY_ZERO
// Description:  Floating-point divide non-zero by zero (5.0 / 0.0)
// Expected: +Infinity (0x7f800000)
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

  li gp, 1

test1:
  li        x6, 5
  li        x7, 0

  fmv.w.x   f0, x6         # f0 = 5.0
  fmv.w.x   f1, x7         # f1 = 0.0

  fdiv.s    f2, f0, f1     # f2 = 5.0 / 0.0 = 0xffffffff7f800000  (+Infinity or NAN)

test2:
  la        x2, inp_data
  flw       f3, 0(x2)      # f3 = 0.0 (loaded from memory)

  fdiv.s    f4, f0, f3     # f4 = 5.0 / 0.0 = 0xffffffff7f800000  (+Infinity or NAN)


  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
  .float 0

RVTEST_DATA_END

