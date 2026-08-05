// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        07-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  raw
// Description:  Verify that RAW hazard occurs when a register is read before it is written back
//               in a 5-stage in-order pipeline.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 2

test1:
  li   x6, 20             # x6 = 20
  li   x4, 10             # x4 = 10

  add  x9, x6, x4         # x9 = 30 (write happens in WB stage)
  addi x10, x9, 50        # Potential RAW hazard if x9 not forwarded; x10 should be 80

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

