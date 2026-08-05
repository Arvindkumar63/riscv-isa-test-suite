/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  counters_functional

  Description:
  Verifies functional behavior of:
  1. Cycle (Dedicated, no setup needed)
  2. Timer (Dedicated, no setup needed)
  3. Instret (Dedicated, no setup needed)
  4. Integer Loads (Requires mhpmevent setup)
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Trap flag

start:
#   Trap handler setup
    la      x2, trap_handler
    csrw    mtvec, x2

# ---------------------------------------------------
#   1. CYCLE CHECK (Dedicated Register)
#   No mhpmevent setup required.
# ---------------------------------------------------
    csrr    x5, mcycle              // Read initial cycle
    nop
    nop
    nop
    csrr    x6, mcycle              // Read final cycle

    bge     x5, x6, fail            // If initial >= final, fail

# ---------------------------------------------------
#   2. INSTRET CHECK (Dedicated Register)
#   No mhpmevent setup required.
# ---------------------------------------------------
    csrr    x5, minstret            // Read initial instret
    nop
    nop
    nop                             // Execute 3 instructions
    csrr    x6, minstret            // Read final instret

    bge     x5, x6, fail            // If initial >= final, fail

# ---------------------------------------------------
#   3. TIMER CHECK (Dedicated Register)
#   No mhpmevent setup required.
# ---------------------------------------------------
    csrr    x5, time                // Read initial time
    li      x10, 100
delay_loop:
    addi    x10, x10, -1
    bnez    x10, delay_loop         // Delay to allow time to tick
    csrr    x6, time                // Read final time

    bge     x5, x6, fail            // If initial >= final, fail

# ---------------------------------------------------
#   4. INTEGER LOAD CHECK (Programmable Event)
#   REQUIRES mhpmevent setup.
# ---------------------------------------------------
setup_load_counter:
    # REPLACE 0x0 WITH YOUR HARDWARE EVENT ID FOR "LOADS"
    li      x5, 0x0                 // Event ID for Integer Load
    csrw    mhpmevent3, x5          // Program Event Selector 3
    
    li      x5, 0
    csrw    mhpmcounter3, x5        // Clear Counter 3
    csrr    x23, mhpmcounter3       // Verify clear (x23 should be 0)

perform_loads:
    la      x6, test_data_loc       // Load address
    lw      x7, 0(x6)               // Load 1
    lw      x7, 4(x6)               // Load 2
    lw      x7, 0(x6)               // Load 3

check_load_counter:
    csrr    x24, mhpmcounter3       // Read Counter 3
    
    # Check logic: We did 3 loads. Counter should be >= 3.
    li      x5, 3
    blt     x24, x5, fail           // If counter < 3, fail

    j       exit

.align 4
trap_handler:
    csrr    x12, mcause
    li      x20, 1
    csrr    x8, mepc
    addi    x8, x8, 4
    csrw    mepc, x8
    mret

exit:
    nop
    nop

    RVTEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
test_data_loc:
    .word 0x11111111
    .word 0x22222222
RVTEST_DATA_END
