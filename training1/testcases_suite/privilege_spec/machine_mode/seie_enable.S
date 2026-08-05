///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          19-11-2025
/// Updated date:	 02-12-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: seie_enable 
/// Description:
/// This test verifies that the supervisor external  Interrupt is triggered when mie.SEIE[9] = 1 & mip.SEIE[9] = 1 and global interrupt bit enable.
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

   li		gp, 4

start:
	la		x4,		trap_handler		// Load handler address
	csrw	mtvec,	x4						// Set mtvec = trap handler address
	nop

	li		x3, 		0x8
	csrr	x2,		mstatus				// Read the default value of mstatus reg, x2= 0x0000000a00000080
	csrs	mstatus, x3 					// Set the 
	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008

level1:
	li x7,0x200
	csrr x5, mip		// default value x5 = 0x0
	csrr x6, mie		// default value x6 = 0x0
	csrr x8, mideleg	// default value x8 = 0x0
//	csrw mideleg, x7	
	csrw mie, x7		// mie is set
	csrw mip, x7		// mip also be set for external interrupt so i have to get interrupts


###	exception interrupt #9, epc 0x0000000080000132
	
level2: 
	addi x6, x7, 8		// due to presence of external interrupt i am not able to observe x6 value

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END


