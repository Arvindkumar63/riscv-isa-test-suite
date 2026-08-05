// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        03-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  TC_JALR_VERIFY
// Description:  Verify that JALR jumps to a register-based address and correctly stores the return address.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 2  

# Test1: JALR with rd = x1

test1:
  li x6, 20               # x6 = 20
  auipc x10, 0            # x10 = current PC
  addi x10, x10, 8        # x10 = address of 'target' (PC + 8)

  jalr x1, x10, 0         # Jump to address in x10, return address saved in x1

  addi x7, x6, 5          # Should be skipped

target:
  addi x9, x6, 7          # x9 = 27

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

