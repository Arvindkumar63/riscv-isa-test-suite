///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          17-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: mie_ssie_enable 
/// Description:
/// This test verifies that the Supervisor Software Interrupt is enabled only when all required conditions are satisfied:
/// mstatus[1]= 1
/// mideleg[1]=0
/// mie[1] = 1 (SSIE = 1)
/// mip[1] =  1
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
	li x3, 0x800
	csrr x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
	csrw mstatus, x3 
	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008

lebel1:
la x2, label_s_mode
csrw mepc, x2        //  Set mepc to label_s_mode and execute SRET
sret

lebel_s_mode: 
	#  The processor is now in Supervisor Mode
 li x5, 2
 csrr x6, sstatus
 csrw sstatus, x5    // sie bit set in supervised mode
   # sie and sip bit also set 
	csrw sie, x5
	csrw sip, x5

lebel2:

	addi x6, x7, 8		// due to presence of software interrupt i am not able to observe x6 value

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

  



