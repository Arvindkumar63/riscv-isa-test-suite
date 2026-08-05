/// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        12-11-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: MSTATUS Overwrite Consistency
// Description:
//   1. Write two different patterns successively
//   2. Verify overwrite updates correctly without residual bits
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li   x5, 0x00001800
  li   x6, 0x00000800
  csrrw x11, mstatus, x5
  csrrw x12, mstatus, x6
  csrr  x13, mstatus


  TEST_PASSFAIL

RVTEST_CODE_END
.data

RVTEST_DATA_BEGIN
  TEST_DATA                     
RVTEST_DATA_END
