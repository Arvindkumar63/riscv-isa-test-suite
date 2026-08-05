///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           04-12-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  ssie_enable
//
//  Description:
//	Verifies Supervisor Software Interrupt (SSIE) triggers in S-mode by enabling SSIE and setting the pending bit (SSIP), also handled the traps for that.
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
//#   CRITICAL: Without this, traps go to M-mode (mtvec)
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
//# ---------------- S-MODE & Trap MUST occur ----------------
//s_mode:
//    li      x8, 0x2                // SSTATUS.SIE mask
//    csrrs   x0, sstatus, x8        // enable SIE
//
//#   enable SSIE in SIE
//    li      x7, 0x2                // SSIE mask
//    csrrs   x0, sie, x7
//
//#   SET SIP.SSIP (Trigger Interrupt)
//    li      x10, 0x2               // SSIP mask
//    csrrs   x0, sip, x10           // Set SSIP
//
//    nop
//    nop
//
//    jal     x0, exit               // Jump to exit (Success)
//
//# ---------------- S-mode trap handler ----------------
//.align 4
//trap_handler:
//    csrr    x12, scause            // read scause
//    
//#   Verify Cause: Supervisor Software Interrupt (Int=1, Code=1)
//#   0x800...001
//    li      x15, 1
//    slli    x15, x15, 63
//    ori     x15, x15, 1
//    bne     x12, x15, fail
//
//    csrr    x13, sepc
//    addi    x13, x13, 4            // skip trapped instr
//    csrw    sepc, x13
//
//#   Clear SIP.SSIP before return
//#   Mandatory to prevent infinite loop
//    li      x14, 0x2
//    csrc    sip, x14               // clear SSIP
//
//    sret                           // return to S-mode
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






























































///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           11-12-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  pmp_load_access_fault
//
//  Description:
//  Verifies PMP Load Access Fault.
//  Configures PMP0 with W=1, X=1, but R=0.
//  S-mode attempts to Load (Read), which should trap.
//==========================================================*/
//
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
//#   Set Trap Handler
//    la      x2, trap_handler
//    csrw    mtvec, x2
//pmp_cfg:
//#   1. Set Address Range (pmpaddr0)
//    csrr x8, pmpaddr0
//    li      x3, 0x80005000
//    srli    x3, x3, 2
//	 li		x8, 0xf// masking
//	 or		x8,x8,x3
//    csrw    pmpaddr0, x8
//	 
//	 la x13,s_mode	
//	 srli		x13, x13, 2
//	 li 		x12, 0xf
//	 or		x12,x12, x13
//	 csrw		pmpaddr1, x12 
//
//#   2. Set Configuration (pmpcfg0)
//#   0x1B = 0001 1011 -> NAPOT(11), X(0), W(1), R(1)
//#   Execute Access is DENIED.
//    li      x4, 0x1F1E
//    csrw    pmpcfg0, x4
//
//mode_switch:
//#   MODE SWITCH (S-mode)
//    la      x6, s_mode
//    csrw    mepc, x6
//
//    li      x3, 0x1800
//    csrc    mstatus, x3
//    li      x3, 0x0800
//    csrs    mstatus, x3
//    mret
//
//#   S-MODE EXECUTION
//s_mode:
//
//    nop
//	 nop
//#   Attempt to Load Data (Read) -> MUST TRAP
//    la      x8, inp_data
//    sw      x3, 0(x8)
//
//    j       exit
//.align 4
//#   TRAP HANDLER
//trap_handler:
//    csrr    x12, mcause
//    
//#   Verify Cause: Instruction Access Fault (1)
//    li      x15, 1
//    bne     x12, x15, fail
//    csrr    x31, mtval 
//
//
//    csrr    x8, mepc
//    addi    x8, x8, 4               // Skip instruction
//    csrw    mepc, x8
//    mret
//
//exit:
//    nop
//    nop
//li x7, 0x80000004
//csrw mtvec, x7
//    TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//	inp_data:
//	.word 0x12345678
//    TEST_DATA
//RVTEST_DATA_END











///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           16-12-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  mstatus_tvm_sfence_trap
//
//  Description:
//  Verifies that setting mstatus.TVM (Bit 20) to 1 causes
//  execution of SFENCE.VMA in S-mode to trigger an
//  Illegal Instruction Exception.
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
//
//
//
//# tvm clear
//li		x4, 0x10000
//csrc	mstatus, x4
//
//# self checking logic
//csrr	x8, mstatus
//and	x9, x4, x8
//bnez  x9, fail
//# s mode switch
//la x5, s_mode
//csrw	mtvec,x5
//
//li x3, 0x1800
//csrc	mstatus, x3
//li	x4, 0x800
//csrs mstatus, x4
//mret
//
//s_mode:
//csrr	x7, satp
//nop
//sfence.vma
//nop
//j	exit
//
//
//.align 4
//trap_handler:
//j	fail
//exit:
//nop
//nop
//
//
//
//TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END










/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           24-11-2025
  Updated Date:   26-11-2025, 03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  ssie_enable

  Description:
  Verifies that enabling SSIE in mie while mip.SSIP is set
  triggers a Software Interrupt. The trap handler captures
  the event and returns.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4


start:

#   Trap handler address 
    la      x2, trap_handler        // Load handler address
    csrw    mtvec, x2               // Set mtvec = trap handler address

#   Enable global interrupts (mstatus.MIE[3] = 1)
    li      x3, 0x8
    csrr    x2, mstatus             // Read default mstatus
    csrrs   x0, mstatus, x3         // Set MIE bit
    csrr    x4, mstatus             // Verify write

level1:

#   Enable mie.SSIE[1] = 1
    li      x13, 0x2
    csrr    x5, mip                // Read default mie
	 csrrs   x12, mip, x13           // Set SSIE (using value from mip 0x2)
	 nop
	 nop
    csrr    x14, mip                // Check mie value
#   Self-check logic: Confirm SSIE are set
    li      x1, 0x2
    bne     x14, x1, fail           // If SSIE != 0x2, fail

#   Set mip.SSIP[1] = 1
    li      x7, 0x2
    csrr    x5, mie                 // Read default mip
    csrrs   x2, mie, x7             // Set SSIP bit
	 nop
	 nop
    csrr    x13, mie                // Check mip value
    nop                             // Wait for interrupt to trigger

    j       exit                    // Jump to exit (skip trap handler in main flow)

.align 4										// Four byte aligned
#   Trap Handler: Handles interrupt and returns
trap_handler:
    csrr    x12, mcause             // Read mcause (Expect mcause[63]=1, mcause value is #1 )

# Self checking logic for mcause
	 li		x2,  0x8000000000000001
	 bne		x12, x2, fail

	 csrr		x11, mtval
	 li		x21, 0x0

    csrr    x8, mepc						// Default value of mepc
    addi    x8, x8, 4               // Increment return address i.e. pc+4.
	 csrw    mepc, x8
#	Clearing the mie and mip bits

	 csrw		mie, x21						
	 csrw		mip, x21
    mret                            // Return to next instruction

exit:
    nop
    nop

# Break the infinite loop
	li 	   x5,  0x80000004
	csrw     mtvec, x5

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END







