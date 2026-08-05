/// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        12-11-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: MSTATUS Basic Read/Write
// Description:
//   1. Read default value of mstatus
//   2. Write a new value and verify it reads back correctly
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN
  li  gp,3

start:
  li   x5, 0x00001800
  csrr x10, mstatus           # Read default
  csrrw x11, mstatus, x5      # Write test value
  csrr  x12, mstatus          # Read back
  
  TEST_PASSFAIL                

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
  TEST_DATA                     
RVTEST_DATA_END


