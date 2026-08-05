/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           19-11-2025
  Updated Date:   03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  stie_enable

  Description:
  This test verifies that the Supervisor Timer Interrupt is 
  triggered only when all required conditions are satisfied:
  mstatus[3] = 1 (MIE)  <-- Note: MIE is bit 3, not 1
  mideleg[5] = 0
  mie[5] = 1 
  mip[5] = 1 
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
    # Trap handler address 
    la      x2, trap_handler    // Load handler address
    csrw    mtvec, x2           // Set mtvec = trap handler address

    # Enable global interrupts (mstatus.MIE[3] = 1)
    li      x3, 0x8
    csrr    x2, mstatus         // Read default mstatus
    csrrs   x0, mstatus, x3     // Set MIE bit
    csrr    x4, mstatus         // Verify write

level1:
    # Ensure mideleg[5] is 0 (delegation disabled for STIP)
    li      x7, 0x20            // Bit 5 mask
    csrc    mideleg, x7         // Clear bit 5 in mideleg

    # Enable mie.STIE[5] = 1
    csrr    x6, mie             // Read default mie
    csrrs   x12, mie, x7        // Set STIE (using 0x20)
    nop
    nop
    csrr    x14, mie            // Check mie value
    
    # Self-check logic: Confirm STIE is set
    li      x1, 0x20
    and     x15, x14, x1        // Isolate bit 5
    bne     x15, x1, fail       // If STIE != 1, fail

    # Set mip.STIP[5] = 1
    # Note: On standard RISC-V, STIP is read-only (reflects timer cmp).
    # Assuming valid write access for this verification environment.
    csrr    x5, mip             // Read default mip
    csrrs   x2, mip, x7         // Set STIP bit (0x20)
    nop
    nop
    csrr    x13, mip            // Check mip value
    nop                         // Wait for interrupt to trigger

    j       exit                // Jump to exit

.align 4                        // Four byte aligned
# Trap Handler: Handles interrupt and returns
trap_handler:
    csrr    x12, mcause         // Read mcause

    # Self checking logic for mcause
    # Expect Interrupt (Bit 63=1) + Code 5 (Supervisor Timer Interrupt)
    li      x2, 0x8000000000000005
    bne     x12, x2, fail

    csrr    x11, mtval
    li      x21, 0x0

    csrr    x8, mepc            // Default value of mepc
    addi    x8, x8, 4           // Increment return address i.e. pc+4
    csrw    mepc, x8
    
    # Clearing the mie and mip bits to stop interrupt loop
    # We clear the specific bits for Timer (Bit 5)
    li      x22, 0x20
    csrc    mie, x22                        
    csrc    mip, x22
    mret                        // Return to next instruction


exit:
    nop
    nop

    # Break the infinite loop / Final cleanup
    li      x5, 0x80000004
    csrw    mtvec, x5

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
