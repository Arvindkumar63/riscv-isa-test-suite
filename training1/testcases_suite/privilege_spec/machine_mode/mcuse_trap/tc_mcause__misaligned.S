//// ===========================================================
//// Copyright 2025 Scaledge India Pvt Ltd - All Rights Reserved
//// Date:       30-09-2025
//// Owner:      Arvind Kumar Kori
//// Description:
////   Simple RISC-V RV64M test demonstrating:
////     1. Trap setup using mtvec
////     2. Loading data from memory
////     3. Reading trap cause and trapped instruction address
//// ===========================================================
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    // Load immediate value into gp register
//    li      gp, 3
//
//start:
//trap:
//    // Load address of level2 into x5 and set mtvec (trap vector)
//    la      x5, level2
//    csrw    mtvec, x5                // Set trap handler address
//
//level1:
//    // Load data from memory
//    la      x6, inp_data             // Load address of inp_data
//    lw      x6, 2(x6)                // Load word from offset 2
//
//level2:
//    // Read trap information
//    csrr    x11, mcause              // Read trap cause
//    csrr    x12, mtval               // Read trapped instruction address
//
//    j       done
//	 //// REASON
///* epc 0x0000000080000120 ##This is the address of the instruction that caused the trap.
//tval 0x0000000080002002  ### tval = Trap Value ##For a load/store misalignment, this shows the faulty memory address that caused the exception.*/
//
//done:
//    nop                               // No operation
//
//   
//    TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//// -----------------------------------------------------------
//// Data Section
//// -----------------------------------------------------------
//.data
//RVTEST_DATA_BEGIN
//
//TEST_DATA
//
//inp_data:
//               
//    .word   0x584944fc               
//    .word   0x584944fc               
//    .dword  0x12345678558f5366      
//    .word   0x558f5366               
//    .word   -0x29df2fb1              // Offset 28: Negative word
//
//RVTEST_DATA_END






/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           30-09-2025
  Updated Date:   26-11-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  load_misaligned

  Description:
  Verifies that a misaligned load instruction triggers a
  Load Address Misaligned exception (mcause=4).
  The trap handler captures the event and returns.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3


start:

#   Trap handler address setup
    la      x2, trap_handler        // Load handler address
    csrw    mtvec, x2               // Set mtvec = trap handler address

level1:
#   Load data from memory to trigger exception
    la      x6, inp_data            // Load address of inp_data
    lw      x6, 2(x6)               // Load word from offset 2 (Misaligned)

    nop
    nop

#   Self-check logic: Confirm Trap Occurred
    li      x1, 1
    bne     x20, x1, fail           // If flag x20 != 1, trap did not fire

#   Self-check logic: Confirm Cause (Load Misaligned = 4)
    li      x1, 4
    bne     x12, x1, fail           // If mcause != 4, fail

#   Self-check logic: Verify mtval (Bad Address)
#   mtval should match the address that caused the trap
    la      x6, inp_data
    addi    x6, x6, 2               // Calculate expected bad address
    bne     x11, x6, fail           // If mtval != (inp_data + 2), fail

    j       exit                    // Jump to exit

.align 4
#   Trap Handler: Handles exception and returns
trap_handler:
    csrr    x12, mcause             // Read mcause (Expect 4 for Load Misaligned)
    csrr    x11, mtval              // Read mtval (Faulty memory address)
    li      x21, 0x0
    li      x20, 1                  // Set flag: Trap successfully entered
    csrr    x8, mepc                // Read Exception Program Counter
    addi    x8, x8, 4               // Increment return address to skip faulty instruction
    csrw    mepc, x8
    csrw    mie, x21
    csrw    mip, x21
    mret                            // Return to next instruction

exit:
    nop
    nop

    RVTEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA

inp_data:
    .word   0x584944fc
    .word   0x584944fc
    .dword  0x12345678558f5366
    .word   0x558f5366
    .word   -0x29df2fb1             // Offset 28: Negative word

RVTEST_DATA_END
