///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:         
/// Updated date: 
/// Owner:         Arvind Kumar Kori
/// Testcase Name: msie_enable 
/// Description:
/// This test verifies that the Supervisor Software Interrupt remains disabled when the SSIE bit in mie is enabled and that pending bit in mip is not set. The interrupt does not trigger.
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
# loading ox8 hexa value in x3 register
		csrr x2, mstatus // read the default value of mstatus reg, x2= 0x0000000a00000080
	// add ox8 li x3, 0x8 
	csrw mstatus, x3 
	csrr x4, mstatus	// after enabling the mie bit in m status, x4= 0x0000000a00000008

level1:
	li x7,0x8
# mip.ssip[3] = 1
	li x8, 0x0000000000000008
	csrr x5, mip		// default value x5 = 0x0
	csrr x2, mideleg
	csrw mideleg, x7	// mideleg[3] = 1
	csrw mstatus, x11

# trap handler
trap_handler:
	csrr x8, mepc
	add  x8, x8, 4
	csrw mepc, x8

	csrr x22, mcause
	csrr x31, mtval

	mret

	csrw mie, x7		// mie.ssie[3] = 1
	csrr x11, mie
# self checking logic
	bne  x11, x8  fail 
	nop
	nop
	csrw mip, x8		// mip.ssip[3] = 1

	
level2: 
	addi x6, x7, 8		// due to presence of software interrupt i am not able to observe x6 value

# use handler logic
	la x2, trap_handler
	csrw mtvec, x2

	csrr x11, mstatus
	li   x5,  0x800
	ori  x11, x11, x5
	csrw mstatus, x11

# trap handler
trap_handler:
	csrr x8, mepc
	add  x8, x8, 4
	csrw mepc, x8

	csrr x22, mcause
	csrr x31, mtval

	mret


    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END



