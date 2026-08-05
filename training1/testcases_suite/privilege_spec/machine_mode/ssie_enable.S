///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          17-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: ssie_enable 
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

//start:
//	li x3, 0x8
//	csrr x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
//	csrw mstatus, x3 
//	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008
//
//level1:
//	li x7,0x2 
//	csrr x5, mip		// default value x5 = 0x0
//	csrr x2, mideleg
////	csrw mideleg, x7	// By default mideleg[1] = 0 thats why i am getting interrupt
//	csrw mie, x7		// mie is set
//	csrw mip, x7		// mip also be set for software interrupt but i don't want any software interrupt so i am not setting mip bits
//
//### exception interrupt #1, epc 0x000000008000012c
//
//level2: 
//	addi x6, x7, 8		// due to presence of software interrupt i am not able to observe x6 value








/////////////////////////////////////////////////////////////////////////
//la x5, trap_handler
//csrw mtvec, x5
//
//start:
//	li x3, 0x8
//	csrr x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
//	csrw mstatus, x3 
//	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008
//
//level1:
//	li x7,0x2 
//	csrr x5, mip		// default value x5 = 0x0
//	csrr x2, mideleg
////	csrw mideleg, x7	// By default mideleg[1] = 0 thats why i am getting interrupt
//	csrw mie, x7		// mie is set
//	csrw mip, x7		// mip also be set for software interrupt but i don't want any software interrupt so i am not setting mip bits
//
//### exception interrupt #1, epc 0x000000008000012c
//trap_handler:
////which trap is there we find it by MCAUSE
//csrr x12, mcause/// mcause = x8=0x8000000000000001 so mcause[1]=1 hence Supervisor software interrupt
//csrr x8, mepc
//addi x8, x8, 4
//csrw mepc, x8
//mret
//level2: 
//	addi x6, x7, 8		// due to presence of software interrupt i am not able to observe x6 value
//////////////////////	///////////////////////////////////////////////////////////////////
//
//start:
//la x5, trap_handler
//csrw mtvec, x5
//
//trap_handler:
////which trap is there we find it by MCAUSE
//csrr x8, mcause
//csrr x8, mepc
//addi x8, x8, 4
//csrw mepc, x8
//mret




/////////////////////////////////////////////////////////////////////////////////////
//           EXCEPTION GENERATION
handler:
la x5, trap_handler
csrw mtvec, x5

start:
la x6, inp_data

lw x7,2(x6)

nop
nop

li x10, 0x20

addi x8, x10,4

jal x0, exit


trap_handler:
//which trap is there we find it by MCAUSE
csrr x12, mcause/// mcause = x8=0x8000000000000001 so mcause[1]=1 hence Supervisor software interrupt
csrr x8, mepc
addi x8, x8, 4
csrw mepc, x8
mret

exit:
nop
nop
li x22, 0x80000004
csrw mtvec, x22//// for the breaking infinite loop, by storing the trap_vector starting address in the mtvec we can overcome this  


    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
inp_data: 
	.word 0x12345678

    TEST_DATA
RVTEST_DATA_END


