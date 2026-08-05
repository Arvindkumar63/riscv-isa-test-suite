// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        11-12-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: default_pmp_reg
// Description:
// Verify the defualt values of pmp address register and pmp configure registers and writable bits.  
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

	li	gp, 3
start:
	li	x3, oxf
	csrr	x4, pmpaddr0
	csrr	x5, pmpcfg0
  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END


