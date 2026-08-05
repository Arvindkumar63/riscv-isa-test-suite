//==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          17-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: mie_ssie_disable 
/// Description:
/// This test verifies that the Supervisor Software Interrupt remains disabled when the SSIE bit in mie is enabled but no software interrupt is pending in mip. The interrupt does not trigger because mip[1] is not set that means:
/// mstatus[1]= 1
/// mideleg[1]= 0
/// mie[1] = 1 (SSIE = 1)
/// mip[1] =  0
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
		li x3, 0x8
csrrs	r	 x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
csrrs	w	 mstatus, x3 
csrrs	r	 x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008

level1:
	li x7,0x2 
	csrr x5, mip		// default value x5 = 0x0
	csrr x2, mideleg
//	csrw mideleg, x7	// mideleg[1]=1 so it will not give interrupt
	csrw mie, x7		// mie is set
//	csrw mip, x7		// mip also be set for software interrupt but i don't want any software interrupt so i am not setting mip bits


level2: 
	addi x6, x7, 8		// due to absence of software interrupt i am getting x6 = 10 value

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
























/*///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date: 24-11-2025        
/// Updated date: 26-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: msie_enable 
/// Description:
/// This test verifies that the Supervisor Software Interrupt remains disabled when the SSIE bit in mie is enabled and that pending bit in mip is not set. The interrupt does not trigger.
/// ===========================================================




/*==========================================================
 Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

 Date:          24-11-2025
 Updated Date:  26-11-2025
 Owner:         Arvind Kumar Kori
 Testcase Name: msie_enable

 Description:
 This test verifies that when SSIE bit in `mie` is enabled
 and mip.SSIP is set then:
     • Software Interrupt should trigger.
     • trap should occur and handled.
 Self-checking logic validates the behavior.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

	li		gp,		4				

start:
#	loading 0x8 hexa value in x3 register and Enable global interrupts (mstatus.MIE[3] = 1)

	li		x3,	0x8
	csrr	x2,	mstatus				// Read the default value of mstatus reg, x2= 0x0000000a00000080
	csrrs	x0,	mstatus,	x3			// Set the x3 reg. value in the mstatus reg. 
	csrr	x4,	mstatus				// Reading the mstatus reg. after set x4= 0x0000000a00000088

level1:
	li		x7,	0x8
#	mip.ssip[3] = 1
	csrr	x5,	mip					// Default value of mip, x5 = 0x0
	csrrs	x2,	mip,	x7				// Set the x7 reg. value in the mip reg. 
	csrr 	x13,	mip					// Check mip value after set
	csrr	x11,	mie					// Default value of mie, x11 = 0x0
	csrrs x12,	mie,	x13			// Set the x13 reg. value in the mie
	csrr 	x14,	mie					// Check mie value after set


#	Self-check logics: Confirm MSIE & MSIP is set
	li		x1,	0x8
	bne	x1,	x13,	fail			// If MSIp not set => fail
	bne	x1,	x13,	fail			// If MSIp not set => fail
                                                                                                        
#	trap handler
trap_handler_logic:
	la		x2,	trap_handler		// Load handler address
	csrw	mtvec,	x2					// Set mtvec = trap handler address
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

	
level3: 
	addi x6, x7, 8		// due to presence of software interrupt i am not able to observe x6 value

# use handler logic
	la x2, trap_handler
	csrw mtvec, x2

	csrr x11, mstatus
	li   x5,  0x800
	or  x11, x11, x5
	csrw mstatus, x11

# trap handler
trap_handler:
	csrr x8, mepc
	addi  x8, x8, 4
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


*/
