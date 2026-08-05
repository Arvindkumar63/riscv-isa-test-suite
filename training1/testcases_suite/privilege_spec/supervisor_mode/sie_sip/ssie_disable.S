///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           12-12-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  ssie_disable
//
//  Description:
//	Verifies Supervisor Software Interrupt (SSIE) not triggers in S-mode by enabling SSIE and disabling the pending bit (SSIP).
//==========================================================*/
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    li      gp, 3
//
//start:
//#   S-mode trap handler (set stvec from M-mode)
//    la      x5, trap_handler       // handler addr
//    csrw    stvec, x5              // set stvec for S-mode
//
//#   Delegation: Delegate SSIP (Bit 1) to S-mode
//    li      x7, 0x2
//    csrw    mideleg, x7
//
//#   Prepare mstatus: set MPP=01 (S-mode)
//    li      x3, 0x1800             // Mask MPP
//    csrc    mstatus, x3            // Clear MPP
//    li      x3, 0x0800             // Set S-mode
//    csrs    mstatus, x3
//
//    la      x6, s_mode
//    csrw    mepc, x6               // next PC for mret
//    mret                           // enter S-mode
//
//# ---------------- S-MODE & Trap Should NOT occur ----------------
//s_mode:
//    li      x8, 0x2                // SSTATUS.SIE mask
//    csrrs   x0, sstatus, x8        // enable SIE
//
//#   enable SSIE in SIE
//    li      x7, 0x2                // SSIE mask
//    csrrs   x0, sie, x7
//    csrr    x9, sie                // read sie
//
//#   self-check: sie.SSIE bit is set
//    and     x9, x9, x7
//    beqz    x9, fail               // SSIE check failed
//
//#   CLEAR SIP.SSIP (Disable Condition)
//    li      x10, 0x2               // SSIP mask
//    csrc    sip, x10               // Clear SSIP
//    csrr    x11, sip               // read sip
//
//#   self-check: sip.SSIP is clear
//    and     x11, x11, x10
//    bnez    x11, fail              // SSIP check failed (bit is set)
//
//    nop
//    nop
//
//    jal     x0, exit               // Jump to exit (Success)
//
//# ---------------- S-mode trap handler ----------------
//.align 4
//trap_handler:
//#   If we are here, Trap Occurred -> FAIL
//    j       fail
//
//# -----------------------------------------------------
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
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    li      gp, 3
//
//
//start:
//
//#   Trap handler address 
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
//
//#   Enable mie.SSIE[1] = 1
//    li      x13, 0x2
//    csrr    x5, mip                // Read default mie
//	 csrrs   x12, mip, x13           // Set SSIE (using value from mip 0x2)
//	 nop
//	 nop
//    csrr    x14, mip                // Check mie value
//#   Self-check logic: Confirm SSIE are set
//    li      x1, 0x2
//    bne     x14, x1, fail           // If SSIE != 0x2, fail
//
//#   Set mip.SSIP[1] = 1
//    li      x7, 0x2
//    csrr    x5, mie                 // Read default mip
//    csrrs   x2, mie, x7             // Set SSIP bit
//	 nop
//	 nop
//    csrr    x13, mie                // Check mip value
//    nop                             // Wait for interrupt to trigger
//
//    j       exit                    // Jump to exit (skip trap handler in main flow)
//
//.align 4										// Four byte aligned
//#   Trap Handler: Handles interrupt and returns
//trap_handler:
//    csrr    x12, mcause             // Read mcause (Expect mcause[63]=1, mcause value is #1 )
//
//# Self checking logic for mcause
//	// li		x2,  0x8000000000000001
//	 //bne		x12, x2, fail
//
//	 csrr		x11, mtval
//	 li		x21, 0x0
//
//    csrr    x8, mepc						// Default value of mepc
//    addi    x8, x8, 4               // Increment return address i.e. pc+4.
//	 csrw    mepc, x8
//#	Clearing the mie and mip bits
//
//	 csrw		mie, x21						
//	 csrw		mip, x21
//    mret                            // Return to next instruction
//
//exit:
//    nop
//    nop
//
//# Break the infinite loop
////	li 	   x5,  0x80000004
////	csrw     mtvec, x5
//
//    TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END
//








#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   Set Trap Handler
    la      x2, trap_handler
    csrw    mtvec, x2
pmp_cfg:
	li		x3, 0xf
	csrw	pmpcfg0, x3
	csrr	x4, pmpcfg0
   nop
	li		x5, 0x80002000
	srli	x5, x5, 2
	//or		x5, x5, x4
	csrw	pmpaddr0, x5
	csrr 	x6, pmpaddr0

la x13, s_mode
srli x13, x13, 2
csrw pmpaddr1, x13
nop
li  x14, 0x0f0f
csrw	 pmpcfg1, x14



mode_switch:
	li		x7, 0x800
	csrw	mstatus, x7
	csrr	x8, mstatus
	la		x9, s_mode
	csrw	mepc,	x9
	mret
	
	
#   S-MODE EXECUTION
s_mode:
	la		x11, inp_data
	lw		x12, 4(x11) /// out of range address
	
	j		exit

.align 4
#   TRAP HANDLER
trap_handler:
	csrr x22, mcause
	csrr x21, mtval
	csrr x23, mepc
	addi x23, x23, 4
	csrw	mepc, x23
	mret

exit:
    nop
    nop

li x7, 0x80000004
csrw mtvec, x7
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
	inp_data:
	.word 0x12345678
    TEST_DATA
RVTEST_DATA_END


