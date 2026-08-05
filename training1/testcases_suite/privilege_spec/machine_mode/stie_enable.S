///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          19-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: stie_enable 
/// Description:
/// This test verifies that the Supervisor Timer Interrupt is triggered only when all required conditions are satisfied:
/// mstatus[1] = 1 (MIE)
/// mideleg[5] = 0
/// mie[5] = 1 
/// mip[5] = 1 
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
	li x3, 0x8
	csrr x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
	csrw mstatus, x3 
	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008

level1:
	li x7,0x20
	csrr x5, mip		// default value x5 = 0x0
	csrr x6, mie		// default value x6 = 0x0
	csrr x8, mideleg	// default value x8 = 0x0
//	csrw mideleg, x7	
	csrw mie, x7		// mie is set
	csrw mip, x7		// mip also be set for timer interrupt so i have to get interrupts
	
level2: 
	addi x6, x7, 8		// due to presence of timer interrupt i am not able to observe x6 value

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END


