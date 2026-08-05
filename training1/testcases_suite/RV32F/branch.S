// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        20-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  fp_compare
// Description:  Test FEQ.S, FLT.S, and FLE.S instructions
//
// ===========================================================

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 3

# Load values: f1 = 2.5, f2 = 2.5, f3 = 4.0
  la x4, val_2_5
  flw f1, 0(x4)

  la x5, val_2_5
  flw f2, 0(x5)

  la x6, val_4_0
  flw f3, 0(x6)

# -------- Test 1: FEQ.S (Equal)
test1:
  feq.s x10, f1, f2       # x10 = 1 (true)
  feq.s x11, f1, f3       # x11 = 0 (false)

# -------- Test 2: FLT.S (Less Than)
test2:
  flt.s x12, f1, f3       # x12 = 1 (2.5 < 4.0)
  flt.s x13, f3, f1       # x13 = 0 (4.0 < 2.5 → false)

# -------- Test 3: FLE.S (Less Than or Equal)
test3:
  fle.s x14, f1, f2       # x14 = 1 (2.5 ≤ 2.5)
  fle.s x15, f1, f3       # x15 = 1 (2.5 ≤ 4.0)
  fle.s x16, f3, f1       # x16 = 0 (4.0 ≤ 2.5 → false)

TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

val_2_5: .float 2.5
val_4_0: .float 4.0

RVTEST_DATA_END

