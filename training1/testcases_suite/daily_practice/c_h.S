// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        08-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  control hazards
// Description:  Verify that control hazard occurs when a conditional branch is mispredicted.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 2

test1:
  li   x6, 20            # x6 = 20
  li   x4, 10            # x4 = 10

  beq  x6, x4, label     # Branch NOT taken (x6 != x4), possible misprediction
  addi x9, x6, 10        # x9 = 30 (executed if branch not taken)

label:
  addi x10, x4, 50       # x10 = 60

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

