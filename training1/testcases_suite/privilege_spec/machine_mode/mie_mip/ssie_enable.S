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
    csrr    x5, mie                 // Read default mie
	 csrrs   x12, mie, x13           // Set SSIE (using value from mip 0x2)
	 nop
	 nop
    csrr    x14, mie                // Check mie value
#   Self-check logic: Confirm SSIE are set
    li      x1, 0x2
    bne     x14, x1, fail           // If SSIE != 0x2, fail

#   Set mip.SSIP[1] = 1
    li      x7, 0x2
    csrr    x5, mip                 // Read default mip
    csrrs   x2, mip, x7             // Set SSIP bit
	 nop
	 nop
    csrr    x13, mip                // Check mip value
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






