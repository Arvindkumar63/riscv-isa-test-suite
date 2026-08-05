/// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        
// Owner:       Arvind Kumar Kori
// Testcase Name: 
// Description:
//   1. Read misa register
//   2. Verify if 'M' extension bit (bit 12) is set
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

	li gp,4
start:
    csrr   x5, misa          // read misa into x5=0x14112d

level1:

  //Mask bit 12 (M extension)
  li     x6, (1 << 12)    
  and    x7, x5, x6

  // If x7 != 0 → 'M' extension supported
  // If x7 == 0 → 'M' extension NOT supported
level2:
li x2,0
csrr x3,misa
csrw misa, x2
  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

