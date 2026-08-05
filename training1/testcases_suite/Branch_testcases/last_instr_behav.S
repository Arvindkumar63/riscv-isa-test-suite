// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        16-06-2025
// Owner:       Arvind & Nikhil
// Testcase name: Two Basic Blocks (1 taken, 1 not taken), and last instruction is different
// Description: Verifies behavior of two different code blocks:
//              - Block 1: 19 branches taken, 20th not taken
//              - Block 2: 19 not-taken, 20th taken
//              Used to observe branch prediction and control flow handling.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp,4
start:

# Registers
li x1, 0         # loop counter
li x2, 0         # dummy reg
li x3, 1         # const
li x4, 19        # loop limit

# --- Block 1: 19 taken, 20th not taken ---
block1_loop:
   addi x1, x1, 1
  blt x1, x4, block1_loop  # loop for 19 times taken 
  bne x1, x4, end1      # NOT taken

li x5, 0xAAAA           # unique final instr

end1:
  nop


# --- Block 2: 19 not taken, 20th taken ---
li x1, 0
li x4,20

block2_loop:
 .rept 19
  addi x1, x1, 1
nop
  beq x1, x4, final_taken  # run till 19
  .endr
final_taken:    # taken on 20th
li x6, 0xBBBB           # unique final instr
addi x4,x1,1
  nop

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

