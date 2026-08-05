// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        11-12-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: rv64_odd_reg_ill
// Description:
// Verify the illegal instruction when odd numbered configuration registers implemented in rv64.  
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

	li	gp, 3
start:
	csrr	x4, pmpcfg1			// exception trap_illegal_instruction,bcz for rv64 the odd numbered configuration registers, pmpcfg1,.. are illigal
	csrr	x5, pmpcfg2

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END




