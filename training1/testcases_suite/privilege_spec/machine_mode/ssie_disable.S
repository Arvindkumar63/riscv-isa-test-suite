//==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          19-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: ssie_disable 
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
	csrr x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
	csrw mstatus, x3 
	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008

level1:
	li x7,0x2 
	csrr x5, mip		// default value x5 = 0x0
	csrr x9, mie		// default value x9 = 0x0
	csrr x2, mideleg	// default value x2 = 0x0
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



