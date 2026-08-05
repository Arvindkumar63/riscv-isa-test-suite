







///*===========================================================
//Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//Date:2/12/2025
//Owner:Sumanth
//Testcase name:SO
//Description:
//===========================================================*/
////Testcase writing section
//#include "test_macros.h"
// 
//#include "riscv_test.h"
//RVTEST_RV64M
// 
//RVTEST_CODE_BEGIN
//  li gp, 3
// 
//  li x1,20
// 
//
//start:
//	csrr x5,mideleg
//	li x6,0xffffffff
//	csrw mideleg,x6
//	csrr x7,mstatus
//	li x8,0x1
//	slli x8,x8,3
//	csrs mstatus,x8
// 
//	li x9,0x1
//	slli x9,x9,11
//	csrs mstatus,x9
// 
//	la x10,smodeg
//	csrw mepc,x10
//	mret
// 
//smode:
// li x1, 2
// csrrs x3, sstatus, x1
//
//	la x12, trap_handler
//
//	csrw stvec,x12
//
//li x5, 0x20
//csrrs x2, sip,x5
//nop
//nop
//	csrrs x4, sie,x5
// .align 4
// jal x0, exit
//trap_handler:
//	csrr x14,scause
//	csrr x16,stval
//	csrr x15,sepc
//	addi x15,x15,4
//	csrw sepc,x15
//   li x15,0x0
//	csrw sip,x15
//	csrw sie,x15
//
//	sret
// 
// 
// exit:
// nop
// nop
//
//TEST_PASSFAIL
//RVTEST_CODE_END
//  .data
//RVTEST_DATA_BEGIN
// 
//  TEST_DATA
//
//RVTEST_DATA_END












/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           24-11-2025
  Updated Date:   26-11-2025
  Owner:          Arvind Kumar Kori
  Testcase Name: timer interrupt then delegation 

  Description:

==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4


start:

#   Trap handler address setup
    la      x2, trap_handler        // Load handler address
    csrw    mtvec, x2               // Set mtvec = trap handler address

#   Enable global interrupts (mstatus.MIE[3] = 1)
    li      x3, 0x8
    csrr    x2, mstatus             // Read default mstatus
    csrrs   x0, mstatus, x3         // Set MIE bit
    csrr    x4, mstatus             // Verify write

level1:
#   Ensure mip.SSIP[1] is 0
    li      x7, 0x2
    csrr    x5, mip                 // Read default mip
    csrc    mip, x7                 // Clear SSIP bit (Ensure it is 0)
    nop
    nop
    csrr    x13, mip                // Check mip value after clear

#   Enable mie.SSIE[1] = 1
    li      x6, 0x2
    csrr    x5, mie                 // Read default mie
    csrrs   x12, mie, x6            // Set SSIE (Using 0x2, not x13)
    csrr    x14, mie                // Check mie value

    nop
    nop                             // Wait to ensure no interrupt triggers

#   Self-check logic: Confirm SSIE is set & SSIP is clear
    li      x1, 0x2
    beq     x13, x1, fail           // If SSIP IS set (0x2) => fail
    bne     x14, x1, fail           // If SSIE NOT set (0x2) => fail

    j       exit                    // Jump to exit

.align 4
#   Trap Handler: Should NOT be entered for this test
trap_handler:
    csrr    x12, mcause             // Read mcause
    csrr    x11, mtval
    li      x21, 0x0
    li      x20, 1                  // Set flag: Trap entered (Failure for this test)
    csrr    x8, mepc
    addi    x8, x8, 4               // Increment return address
    csrw    mepc, x8
    csrw    mie, x21
    csrw    mip, x21
    mret                            // Return

exit:
    nop
    nop

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
