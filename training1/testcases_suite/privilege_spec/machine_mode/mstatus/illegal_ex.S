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
//	change mode from machine to u mode
	li x5, 0x800
//	set mpp bit [12:11] = 10 for mode switching 
	csrw mstatus, x5
		csrr x4, mstatus

//	store the trap handler 
	la x9, switch_m_to_s
		csrw mepc, x9
		csrr x1, mepc

li x3, 0x1
	la x12, trap_handler    // setup trap handler
	csrw mtvec, x12


	csrr x13, mtvec

//	csrw mcounteren, x3// so illigal exception trap not generated else generate
	csrr x2, mcounteren
	csrr x5, mcycle


	mret	

switch_m_to_s:
	csrr x9, cycle



lebel:
	addi x6, x5, 2 

trap_handler:
csrr x14, mcause
li      x2, 2                 # Illegal instruction cause = 2
    beq     x14, x2, trap_pass
trap_fail:
    li x1, 0xBAD
    j end_test
trap_pass:
    li x1, 0xACE
end_test:
    j end_test






    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
