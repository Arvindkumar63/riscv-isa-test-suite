
/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           04-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  misa_check

  Description:
  Verifies the misa CSR:
  1. Checks if 'M' extension (Bit 12) is valid/present.
  2. Performs a Read-Only check by forcefully writing .
     The test fails if the value changes (write successful).
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
   
start:
#   Trap handler setup
    la      x2, trap_handler
    csrw    mtvec, x2

#   Read initial misa value
    csrr    x5, misa                // x5 = Original Value

level1:
#   Check for 'M' Extension (Bit 12)
    li      x6, 0x1000              // Mask for Bit 12 (1 << 12)
    and     x7, x5, x6              // Extract bit 12
    beqz    x7, fail                // If 0, M-extension missing -> Fail

level2:
#   Read-Only Check: Forcefully write 
    li      x2, 0xffffffffffffffff
    csrw    misa, x2                // Attempt to clear misa

#   Read back to verify
    csrr    x3, misa                // x3 = New Value

#   Self-check: Value should NOT change
    bne     x3, x5, fail            // If New != Original, write succeeded -> Fail

    j       exit

.align 4
#   Trap Handler (Should not trigger, but good for safety)
trap_handler:
    csrr    x12, mcause
   
exit:
    nop
    nop
	 # Break the infinite loop
	li 	   x5,  0x80000004
	csrw     mtvec, x5

   TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END


