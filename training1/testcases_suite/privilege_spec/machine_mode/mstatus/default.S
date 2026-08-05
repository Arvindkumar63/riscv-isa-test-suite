///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          20-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: mcounteren_cycle_set 
/// Description:
/// This test clears mcounteren[0] = 1, then switches to U‑mode using MPP=01 + MRET.
/// After entering S mode, executing csrr xN, cycle must immediately clear and not raise an illegal‑instruction exception because CY=1 for U/S-mode access.
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
h:
start: 
//	change mode from machine to u mode
	li x5, 0x1000
//	set mpp bit [12:11] = 10 for mode switching 
	csrw mstatus, x5
		csrr x4, mstatus

//	store the trap handler 
	la x9, switch_m_to_h
		csrw mepc, x9
		csrr x1, mepc
	mret	

switch_m_to_h:
	nop

lebel:
	addi x6, x5, 2 



    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
