/// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-09-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: MRET Transition to Supervisor Mode
// Description: 
//   1. Setup mstatus.MPP = S-mode (01)
//   2. Set csrw to label_smode_entry
//   3. Execute MRET (should drop privilege from M-mode → S-mode)
//   4. Verify by reading current privilege level (CSR: mstatus)  
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M
RVTEST_CODE_BEGIN

  // Set MPP = S-mode (01)
  csrr   x5, mstatus
  li     x6, 0xFFFFFFFFFFFFE7FF    // clear MPP[12:11]
  and    x5, x5, x6
  li     x6, 0x0000000000000800    // set MPP=01
  or     x5, x5, x6
  csrw   mstatus, x5

  // Set mepc and jump with MRET
  la     x7, label_smode_entry
  csrw   mstatus, x5
  andi   x9, x9, 3

  mret

label_smode_entry:
  // Verify MPP cleared → now in S-mode
  csrr   x8, mstatus
  srli   x9, x8, 11
  andi   x9, x9, 3
 

  TEST_PASSFAIL                

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
