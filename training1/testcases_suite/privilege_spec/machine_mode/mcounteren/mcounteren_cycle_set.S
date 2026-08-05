/////==========================================================
///// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
/////
///// Date:          20-11-2025
///// Owner:         Arvind Kumar Kori
///// Testcase Name: mcounteren_clear 
///// Description:
///// This test clears mcounteren[0] = 0, then switches to U‑mode using MPP=00 + MRET.
///// After entering U‑mode, executing csrr xN, cycle must immediately raise an illegal‑instruction exception because CY=0 forbids U/S-mode access.
///// Trap handler must be triggered and the handler verifies that the cause is illegal instruction.
///// ===========================================================
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    li    gp,	4
//
//#	trap handler address
//trap_handler_address:
//	la		x6,	trap_handler				// Load handler address 
//	csrw	mtvec,x6						      // Set mtvec = trap handler address
//	nop
//	nop
//	csrr	x8,	mtval
//
//start:
//#	Setting CY bit of mcounteren csr register 
//	csrrsi x6,	mcounteren,	1
//#	laoding 0x800 hexa value in x5 register and setting mpp bit = 01
//	li		x5, 	0x800
//	csrrs	x12,	mstatus,	x5					//	set mpp bit [12:11] = 01 for mode switching from m to s 
//	nop
//	nop
//	csrr	x4,	mstatus					   // Check mstatus value after set
//#	---- Self-check: verify mstatus[12:11] == 01 (MPP == 1)
//#	shift right by 11, mask 2 bits, compare with 1
//	srli	x10,	x4,	11
//	andi	x10,	x10,	0x3
//	li		x11,	1
//	bne	x10,	x11,	fail					// if not equal -> fail
//
//# 	If check passes, continue
//
//#	load the trap handler for mode switching 
//	la		x9,	switch_m_to_s
//	csrw	mepc,	x9
//	mret											// machine return to the address of mepc value for mode switching
//
//
//switch_m_to_s:
//	csrr	x9,	cycle
//
//label:
//	addi	x8,	x11,	1
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








/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           20-11-2025
  Updated Date:   26-11-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mcounteren_clear

  Description:
  This test clears mcounteren[0] (CY) = 0, then switches to
  U-mode (MPP=00). After entering U-mode, executing
  `csrr xN, cycle` must raise an Illegal Instruction exception
  because CY=0 forbids U-mode access.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4


start:

#   Trap handler address setup
    la      x6, trap_handler        // Load handler address
    csrw    mtvec, x6               // Set mtvec = trap handler address

#   Clear mcounteren[0] (CY bit)
    li      x6, 1
    csrc    mcounteren, x6          // Clear CY bit (Prevent U-mode access)

#   Configure mstatus for U-mode switch (MPP=00)
    li      x5, 0x1800              // MPP mask (bits 11 and 12)
    csrc    mstatus, x5             // Clear MPP bits -> Mode 0 (User)
    csrr    x4, mstatus             // Verify write

#   Self-check: Verify MPP is 0 (U-mode)
    srli    x10, x4, 11
    andi    x10, x10, 0x3
    li      x11, 0
    bne     x10, x11, fail          // If MPP != 0, fail

#   Setup return address to U-mode code
    la      x9, switch_m_to_u
    csrw    mepc, x9
    mret                            // Return to U-mode

switch_m_to_u:
    csrr    x9, cycle               // Should trigger Illegal Instruction Trap
    ecall                           // Exit test (Handled by trap handler)

    j       fail                    // Should not reach here

.align 4
#   Trap Handler
trap_handler:
    csrr    x12, mcause             // Read trap cause
    csrr    x11, mtval
    li      x21, 0x0

#   Check for Illegal Instruction (Cause 2)
    li      x1, 2
    beq     x12, x1, handle_illegal

#   Check for User Ecall (Cause 8) - Used to exit test
    li      x1, 8
    beq     x12, x1, handle_exit

    j       fail                    // Unexpected trap

handle_illegal:
    li      x20, 1                  // Set flag: Success (Trap occurred)
    csrr    x8, mepc
    addi    x8, x8, 4               // Skip faulty instruction
    csrw    mepc, x8
    csrw    mie, x21
    csrw    mip, x21
    mret                            // Return to U-mode (to execute ecall)

handle_exit:
    li      x1, 1
    bne     x20, x1, fail           // If x20 is not 1, we didn't trap earlier -> Fail
    j       exit                    // Test Passed

exit:
    nop
    nop

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
