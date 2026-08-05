///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           24-11-2025
//  Updated Date:   26-11-2025, 03-11-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  ssie_disable
//
//  Description:
//  This test verifies that when SSIE bit in mie is enabled
//  and mip.SSIP is not set then:
//      • Software Interrupt should not trigger.
//      • Trap should not occur.
//  Self-checking logic validates the behavior.
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
//    # Enable global interrupts (mstatus.MIE[3] = 1)
//    li      x3, 0x8
//    csrr    x2, mstatus         // Read default mstatus
//    csrrs   x0, mstatus, x3     // Set MIE bit
//    nop
//    nop
//    csrr    x4, mstatus         // Verify write (x4 should be ...88)
//
//level1:
//    # Ensure mip.SSIP[1] is CLEARED (0)
//    li      x7, 0x2
//    csrr    x5, mip             // Read default mip
//    csrc    mip, x7             // Explicitly Clear SSIP bit to ensure it is 0
//    nop
//    nop
//    csrr    x13, mip            // Check mip value (Expect 0 or at least bit 1 is 0)
//
//    # Enable mie.SSIE[1] = 1
//    # BUG FIX: We must use x7 (value 0x2) to set mie, NOT x13 (which is 0)
//    csrr    x11, mie            // Read default mie
//    csrrs   x12, mie, x7        // Set SSIE bit (Using 0x2)
//    nop
//    nop
//    csrr    x14, mie            // Check mie value
//
//    # Self-check logic: Confirm SSIE is set (2) and SSIP is clear (0)
//    li      x1, 0x2
//    
//    # Check if SSIP (bit 1 of x13) is set. 
//    # We AND with 0x2 to isolate the bit. If result != 0, it failed.
//    andi    x15, x13, 0x2
//    bnez    x15, fail           // If SSIP is set, Fail.
//
//    # Check if SSIE (bit 1 of x14) is set.
//    # We AND with 0x2. If result != 2, it failed.
//    andi    x16, x14, 0x2
//    bne     x1, x16, fail       // If SSIE is not set, Fail.
//
//    # Wait to ensure no interrupt happens
//    nop
//    nop
//    nop
//
//
//
//    TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END
// Result: In our core machine mode trap not occurs because mip not setting.






///*==========================================================
// Copyright  2025 Scaledge India Pvt Ltd
//
// Testcase Name : ssie_enable
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
//    li      gp,     3                   
//
//
//start:
//#   S-mode trap handler (set stvec from M-mode)
//
//    la      x5,     trap_handler       // handler addr
//    csrw    stvec,  x5                 // set stvec for S-mode
//    nop
//    nop
//
//# prepare mstatus: set MPP=01 (S-mode)mstatus[12:11] = 01,mstatus[1]=1 and mstatus[3]=1 
//    csrr    x2,     mstatus				// Default value of mstatus register
//    li      x3,     0x80A              // 
//    csrrs   x12, mstatus, x2
//    la      x6,     s_mode
//    csrw    mepc,   x6                  // next PC for mret
//    mret                                // enter S-mode
//
//# ---------------- S-MODE & tranp occurs in this mode ----------------
//s_mode:
//    li      x8,     0x2                 // SSTATUS.SIE mask
//  //  csrrs   x0,     sstatus, x8        // enable SIE
//
//# enable SSIE in SIE
//    li      x7,     0x2                 // SSIE mask
//    csrrs   x0,     sie,     x7
//    csrr    x9,     sie                 // read sie
//# self-check: mie.SSIE bit is set
//    li      x1,     0x2
//    bne     x1,     x9,     fail        // SSIE check 
//
//
//# set SIP.SSIP to pend supervisor SW interrupt
//    li      x10,    0x2                 // SSIP mask
//    csrrs   x0,     sip,     x10
//    csrr    x11,    sip                 // read sip
//
//
//    jal     x0,     exit                // avoid hang
//
//# ---------------- S-mode trap handler (runs in S-mode) ----------------
//.align 4
//trap_handler:
//    csrr    x12,    scause              // read scause
//#	self  checking logic for scause
//
//
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
                                                                                           










///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           04-12-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  stie_enable_smode
//
//  Description:
//  Verifies Supervisor Timer Interrupt (STIE) in S-mode:
//    1. Delegate STIP to S-mode (mideleg).
//    2. Force Set STIP in M-mode (mip).
//    3. Enter S-mode via mret.
//    4. Enable STIE & SIE.
//    5. Handle trap in S-mode handler.
//==========================================================*/
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    li      gp, 3
//    li      x20, 0                  // Initialize trap flag
//
//start:
//#   -------------------------------------------------
//#   M-MODE SETUP
//#   -------------------------------------------------
//
//#   1. Set S-mode Trap Handler
//    la      x5, trap_handler
//    csrw    stvec, x5
//
//#   2. DELEGATION (Critical Step)
//#   Delegate Supervisor Timer Interrupt (Bit 5) to S-mode.
//    li      x7, 0x20                // Bit 5 mask (STIP)
//    csrw    mideleg, x7             // Write to mideleg
//
//#   3. FORCE PENDING INTERRUPT
//#   Set mip.STIP (Bit 5) = 1.
//#   This forces a pending timer interrupt visible in S-mode sip.
//    csrrs   x0, mip, x7
//
//#   4. Prepare for S-mode transition
//    la      x6, s_mode
//    csrw    mepc, x6                // Set return address
//
//#   5. Configure mstatus (MPP=01 for S-mode)
//    li      x3, 0x1800              // Mask for MPP
//    csrc    mstatus, x3             // Clear MPP
//    li      x3, 0x0800              // Set MPP = 01 (S-mode)
//    csrs    mstatus, x3
//
//    mret                            // Enter S-mode
//
//#   -------------------------------------------------
//#   S-MODE EXECUTION
//#   -------------------------------------------------
//s_mode:
//#   1. Enable Global Interrupts (SIE) in sstatus
//    li      x8, 0x2                 // Bit 1 (SIE)
//    csrrs   x0, sstatus, x8         // Set SIE
//
//#   2. Enable STIE in sie (This should trigger the trap)
//    li      x7, 0x20                // Bit 5 (STIE)
//    csrrs   x0, sie, x7
//
//#   Self-check: Verify STIE is set
//    csrr    x9, sie
//    and     x9, x9, x7
//    beqz    x9, fail
//
//#   Trap should have occurred by now.
//    nop
//    nop
//
//#   Self-check: Confirm Trap Occurred
//    li      x1, 1
//    bne     x20, x1, fail           // If x20 != 1, trap failed
//
//    j       exit
//
//#   -------------------------------------------------
//#   S-MODE TRAP HANDLER
//#   -------------------------------------------------
//.align 4
//trap_handler:
//    csrr    x12, scause             // Read scause
//    li      x20, 1                  // Set success flag
//
//#   Verify Cause: Supervisor Timer Interrupt (Interrupt=1, Code=5)
//#   0x800...005
//    li      x15, 5
//    slli    x15, x15, 63            // Set MSB (Interrupt bit)
//    ori     x15, x15, 5             // Cause 5
//    bne     x12, x15, fail
//
//    csrr    x13, sepc
//    addi    x13, x13, 4             // Skip instruction
//    csrw    sepc, x13
//
//#   CRITICAL: Disable STIE in sie
//#   We cannot clear sip.STIP in S-mode (it's read-only).
//#   To avoid an infinite loop, we must disable the interrupt enable bit.
//    li      x14, 0x20
//    csrc    sie, x14
//
//    sret                            // Return to S-mode
//
//#   -------------------------------------------------
//#   EXIT / FAIL
//#   -------------------------------------------------
//exit:
//    nop
//    nop
//    RVTEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END












/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           04-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  misa_check

  Description:
  Verifies the misa CSR:
  1. Checks if 'M' extension (Bit 12) is valid/present.
  2. Performs a Read-Only check by forcefully writing 0.
     The test fails if the value changes (write successful).
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Initialize trap flag

start:
#   Trap handler setup
    la      x2, trap_handler
    csrw    mtvec, x2

#   Read initial misa value
    csrr    x5, misa                // x5 = Original Value

level1:
#   Check for 'M' Extension (Bit 12)
    li      x6, 0x1000              // Mask for Bit 12 (1 << 12)
    and     x7, x5, x6              // Extract bit 12
    beqz    x7, fail                // If 0, M-extension missing -> Fail

level2:
#   Read-Only Check: Forcefully write 0
    li      x2, 0
    csrw    misa, x2                // Attempt to clear misa

#   Read back to verify
    csrr    x3, misa                // x3 = New Value

#   Self-check: Value should NOT change
    bne     x3, x5, fail            // If New != Original, write succeeded -> Fail

    j       exit

.align 4
#   Trap Handler (Should not trigger, but good for safety)
trap_handler:
    csrr    x12, mcause
    li      x20, 1
    j       fail                    // If we trap on misa access, it's a fail here

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


