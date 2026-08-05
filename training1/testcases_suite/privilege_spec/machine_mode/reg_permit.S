///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          20-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: meie_disable 
/// Description:
/// This test verifies that the machine external  Interrupt is triggered only when all required conditions are satisfied:
/// mstatus[1] = 1 (MIE)
/// mideleg[11] = 0
/// mie[11] = 1 
/// mip[11] = 1 
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start: 
//	change mode from machine to s mode
	li x5, 0x800
//	set mpp bit [12:11] = 01 for mode switching 
	csrr x4, mstatus
	csrw mstatus, x5
//	store the trap handler 
	la x9, switch_m_to_s
	csrr x1, mepc
	csrw mepc, x9
	mret	// instruction for machine mode retired

switch_m_to_s:
	li x3, 0x10
	csrw mcouneren, x3
	csrr x2, mcounteren
	csrr x5, cycle

lebel:
	addi x6, x5, 2 



    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
