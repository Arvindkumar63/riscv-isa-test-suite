// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        08-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  structural hazards 
// Description:  Verify that structural hazards occur when multiple instructions
//               access the same resource (e.g., memory) at the same clock cycle.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 2

test1:
  la   x2, inp_data       # Load address of memory
  li   x6, 20             # x6 = 20
  li   x4, 50             # x4 = 50

  lw   x12, 0(x2)         # Load word from memory (MEM stage uses memory)
  addi x8, x6, 10         # x8 = 30
  addi x9, x4, 50         # x9 = 100
  sw   x9, 0(x2)          # Store to same memory (MEM stage again uses memory)

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
  .word 0x12345678        # Initial memory content

RVTEST_DATA_END

