///*===========================================================
//Copyright  2025 Scaledge India Pvt Ltd - All Rights Reserved.
//Date: 01/12/2025
//Owner: Arvind Kumar Kori
//
//Testcase name: tc_del_EBREAK
//Description:
//  Verify that EBREAK (debug breakpoint) traps to S-mode if MEDELEG is set.
//===========================================================*/
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//start:
//    li      gp, 3
//
//# Setup M-mode trap handler
//trap_handler_address:
//    la      x4, trap_handler
//    csrw    mtvec, x4
//
//# Delegate all synchronous exceptions to S-mode
//label1:
//    li      x8, 0xFFFFFFFF
//    csrw    medeleg, x8
//    csrr    x9, medeleg				// x9=0x000000000000b309
//
//# Switch to S-mode (MPP=S-mode)
//label3:
//    li      x11, 0x800
//    csrrs   x7, mstatus, x11
//    la      x2, s_mode_entry
//    csrw    mepc, x2
//    mret
//
//# Install S-mode trap handler
////label4:
//    //la      x16, s_trap_handler
//    //csrw    stvec, x16
//    
//
//# Generate EBREAK in S-mode
//s_mode_entry:
//	la x29,s_trap_handler
//	csrw stvec,x29
//    li      x6, 0x0
//    ebreak                             # Trap should go to S-mode
//    add x31,x8,x11              # Fail if trap not taken
//	 nop
//	 nop
//    jal x0,pass1						// self checking 
//# M-mode handler (should not execute)
//trap_handler:
//    csrr    x23, mepc
//    addi    x23, x23, 4
//    csrw    mepc, x23
//    j       fail						// self checking 
//
//.align 4
//
//# S-mode trap handler
//s_trap_handler:
//	csrr x28,scause
//    csrr    x12, sepc
//    addi    x12, x12, 4
//    csrw    sepc, x12
//    csrr    x20, scause
//    csrr    x10, stval
//    li      x21, 3                     # Breakpoint exception code
//    sret
//
//	 pass1:
//	 nop
//	 nop
//	 jal x0,shakti_end
//TEST_PASSFAIL
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END










//
//#include "test_macros.h"
//#include "riscv_test.h"
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//  li gp, 3
//  li x1,20
// 
//handler:
//la x5, trap_handler
//csrw mtvec, x5
// 
//li x3, 0x808       // mpp=01 and mie bit set
//	csrr x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
//	csrw mstatus, x3 
//	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008
// 
//level1:
//la x6, s_mode
//csrw mepc, x6
//mret
//
//s_mode:
//li x8, 2
//csrrs x2,	sstatus, x8
//
//	li x7,2
//		csrw sie, x7		// mie is set	
//	csrw sip, x7		// mip bit set so interrupt will generate
//
//	csrr x5, sip		// default value x5 = 0x0
//	csrr x9, sie		// default value x9 = 0x0
//	addi x6, x7, 8
//	nop
//	nop
//
//level2: 
//	addi x6, x7, 8
//	jal x0,exit
// 
//.align 4
//trap_handler:
//csrr x12, mcause/// mcause = x8=0x8000000000000001-> mcause[1]=1 hence Supervisor software interrupt
//csrr x8, mepc
//addi x8, x8, 4
//csrw mepc, x8
//li x7,0x0
//csrw mie, x7		// mie is set	
//csrw mip, x7		// mip bit set so interrupt will generate
//mret
// 
//exit:
//nop
//nop
//li x22, 0x80000004
// 
//TEST_PASSFAIL
//RVTEST_CODE_END
//  .data
//RVTEST_DATA_BEGIN
//  TEST_DATA
//inp_data: 
//	.word 0x12345678
//	.word 0x12345678
//RVTEST_DATA_END



















///*==========================================================
// Copyright  2025 Scaledge India Pvt Ltd
//
// Testcase Name : ssie_enable_in_sie
// Description   :
//   • enter S-mode
//   • enable SSIE & set SIP.SSIP
//   • supervisor software interrupt handled
//==========================================================*/
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    li      gp,     3                   // temp
//
//# install S-mode trap handler (set stvec from M-mode)
//handler:
//    la      x5,     trap_handler        // handler addr
//    csrw    stvec,  x5                 // set stvec for S-mode
//    nop
//    nop
//
//# prepare mstatus: set MPP=01 (S-mode) and preserve other bits safely
//start:
//    li      x3,    0x80A
//	
//	csrrs x5, mstatus,   x6                  // next PC for mret
//  csrr x9, mstatus 
//	level3:
//la x7, s_mode
//csrw mepc, x7
//mret
//# ---------------- S-MODE ----------------
//s_mode:
//    li      x8,     0x2                 // SSTATUS.SIE mask
//    csrrs   x0,     sstatus, x8        // enable SIE
//
//# enable SSIE in SIE
//    li      x7,     0x2                 // SSIE mask
//    csrrs   x0,     sie,     x7
//    csrr    x9,     sie                 // read sie
//
//# set SIP.SSIP to pend supervisor SW interrupt
//    li      x10,    0x2                 // SSIP mask
//    csrrs   x0,     sip,     x10
//    csrr    x11,    sip                 // read sip
//
//# self-check: SSIE & SSIP must be set
//    li      x1,     0x2
//    bne     x1,     x9,     fail        // SSIE check
//    bne     x1,     x11,    fail        // SSIP check
//
//    jal     x0,     exit                // avoid hang
//
//# ---------------- S-mode trap handler (runs in S-mode) ----------------
//.align 4
//trap_handler:
//    csrr    x12,    scause              // read scause
//    csrr    x13,    sepc                // read sepc
//    addi    x13,    x13,    4
//    csrw    sepc,   x13                 // skip trapped instr
//
//# clear SIP.SSIP before return
//    li      x14,    0x2
//    csrc    sip,    x14                 // clear SSIP
//
//    sret                                // return to S-mode
//
//# ---------------------------------------------------------------------
//
//exit:
//    nop
//    nop
//    TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END
//




















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
// jal x0, exit
//trap_handler:
//	csrr x14,scause
//	csrr x16,stval
//	csrr x15,sepc
//	addi x15,x15,4
//	csrw sepc,x15
//li x15,0x0
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














///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           24-11-2025
//  Updated Date:   26-11-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  ssie_enable
//
//  Description:
//  Verifies that enabling SSIE in `mie` while `mip.SSIP` is set
//  triggers a Software Interrupt. The trap handler captures
//  the event and returns.
//==========================================================*/
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    li      gp, 4
//                  
//start:
//#   Trap handler address setup
//    la      x2, trap_handler        // Load handler address
//    csrw    mtvec, x2               // Set mtvec = trap handler address
//
//#   Enable global interrupts (mstatus.MIE[3] = 1)
//    li      x3, 0x8
//    csrr    x2, mstatus             // Read default mstatus
//    csrrs   x0, mstatus, x3         // Set MIE bit
//    csrr    x4, mstatus             // Verify write
//
//level1:
//#   Set mip.SSIP[1] = 1
//    li      x7, 0x2
//    csrr    x5, mip                 // Read default mip
//    csrrs   x2, mip, x7             // Set SSIP bit
//    csrr    x13, mip                // Check mip value
//
//#   Enable mie.SSIE[1] = 1
//    csrrs   x12, mie, x13           // Set SSIE (using value from mip 0x2)
//    csrr    x14, mie                // Check mie value
//
//#   Self-check logic: Confirm SSIE & SSIP are set
//    li      x1, 0x2
//    bne     x13, x1, fail           // If SSIP != 0x2, fail
//    bne     x14, x1, fail           // If SSIE != 0x2, fail
//
//#   Self-check logic: Confirm Trap Handler Executed
//    li      x1, 1
//    bne     x20, x1, fail           // If flag x20 != 1, interrupt did not fire
//
//    j       exit                    // Jump to exit (skip trap handler in main flow)
//.align 4
//
//#   Trap Handler: Handles interrupt and returns
//trap_handler:
//    csrr    x12, mcause             // Read mcause (Expect mcause[63]=1, mcause[1]=1)
//	 csrr		x11, mtval					// Read mtval 
//    li      x20, 1                  // Set flag: Trap successfully entered
//    csrr    x8, mepc
//    addi    x8, x8, 4               // Increment return address to skip instruction
//    csrw    mepc,	x8
//	 li		x9, 0x0
//	 csrw		mie,	x9
//	 nop
//	 csrw		mip,	x9
//    mret                            // Return to next instruction
//
//exit:
//    nop
//    nop
//    TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END




/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
Date:2/12/2025
Owner:Sumanth
Testcase name:SO
Description:
===========================================================*/
//Testcase writing section
#include "test_macros.h"
 
#include "riscv_test.h"
RVTEST_RV64M
 
RVTEST_CODE_BEGIN
  li gp, 3
 
  li x1,20
 

start:
	csrr x5,mideleg
	li x6,0xffffffff
	csrw mideleg,x6
	csrr x7,mstatus
	li x8,0x1
	slli x8,x8,3
	csrs mstatus,x8
 
	li x9,0x1
	slli x9,x9,11
	csrs mstatus,x9
 
	la x10,smodeg
	csrw mepc,x10
	mret
 
smode:
 li x1, 2
 csrrs x3, sstatus, x1

	la x12, trap_handler

	csrw stvec,x12

li x5, 0x20
csrrs x2, sip,x5
nop
nop
	csrrs x4, sie,x5
 .align 4
 jal x0, exit
trap_handler:
	csrr x14,scause
	csrr x16,stval
	csrr x15,sepc
	addi x15,x15,4
	csrw sepc,x15
   li x15,0x0
	csrw sip,x15
	csrw sie,x15

	sret
 
 
 exit:
 nop
 nop

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
 
  TEST_DATA

RVTEST_DATA_END


