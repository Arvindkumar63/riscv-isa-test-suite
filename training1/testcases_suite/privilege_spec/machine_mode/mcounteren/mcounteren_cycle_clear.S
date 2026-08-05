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
//
//start:
//#	clearing all bits in the mcounteren csr register by writing 0 in that register
//	csrrwi x6,	mcounteren,	0
//#	laoding 0x800 hexa value in x5 register and setting mpp bit = 01
//	li		x5, 	0x800
//	csrrs	x12,	mstatus,	x5					//	set mpp bit [12:11] = 01 for mode switching from m to s 
//	nop
//	nop
//	csrr	x4,	mstatus					   // Check mstatus value after set
//#	---- Self-check 1: verify mstatus[12:11] == 01 (MPP == 1)
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
//	jal	x0,	exit
//
//trap_handler:
//	csrr	x7,	mcause						// Which trap is there handled by mcause => mcause[63] = 0 so exception and if 1 then interrupt traps and 
//#	Self-check 2: expect mcause[63] == 0 (exception, not interrupt)
//#  shift mcause right 63 to extract the top bit and ensure zero
//	srli	x12,	x7,	63
//	bne	x12,	x0,	fail					// if top bit = 1 (interrupt) -> fail
//	
// 	csrr	x8,	mepc
// 	addi	x8,	x8,	4
//	csrw	mepc,	x8
//	mret											// machine return to the address of mepc value for trap handler
//
//
//switch_m_to_s:
//	csrr	x9,	cycle
//
////trap_handler:
////	csrr	x7,	mcause						// Which trap is there handled by mcause => mcause[63] = 0 so exception and if 1 then interrupt traps and 
////#	Self-check 2: expect mcause[63] == 0 (exception, not interrupt)
////#  shift mcause right 63 to extract the top bit and ensure zero
////	srli	x12,	x7,	63
////	bne	x12,	x0,	fail					// if top bit = 1 (interrupt) -> fail
////	
//// 	csrr	x8,	mepc
//// 	addi	x8,	x8,	4
////	csrw	mepc,	x8
////	mret											// machine return to the address of mepc value for trap handler
////
//	
//exit:
//
//	li		x22,	0x80000146
//	csrw	mtvec,x22							// for the breaking infinite loop, by storing the trap_vector starting address in the mtvec we can overcome this  
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
//










/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           20-11-2025
  Updated Date:   26-11-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mcounteren_clear

  Description:
  This test clears mcounteren[0] (CY), then switches to
  S-mode (MPP=01). After entering S-mode, executing
  `csrr xN, cycle` must raise an Illegal Instruction exception.
  The trap handler verifies the cause and returns.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Initialize trap flag (0 = no trap)

start:

#   Trap handler address setup
    la      x6, trap_handler        // Load handler address
    csrw    mtvec, x6               // Set mtvec = trap handler address

#   Clear all bits in mcounteren (CY=0)
    csrrwi  x6, mcounteren, 0

#   Set MPP bit [12:11] = 01 (Supervisor Mode)
    li      x5, 0x800
    csrrs   x12, mstatus, x5        // Set MPP bits
    csrr    x4, mstatus             // Verify write

#   Self-check 1: verify mstatus[12:11] == 01 (MPP == 1)
    srli    x10, x4, 11
    andi    x10, x10, 0x3
    li      x11, 1
    bne     x10, x11, fail          // If MPP != 1, fail

#   Load the trap handler for mode switching
    la      x9, switch_m_to_s
    csrw    mepc, x9
    mret                            // Return to S-mode (jumps to switch_m_to_s)

    j       fail                    // Should not reach here

#   Code executed in S-mode
switch_m_to_s:
    csrr    x9, cycle               // Should trigger Illegal Instruction Trap
    
    # Check if trap occurred
    li      x1, 1
    bne     x20, x1, fail           // If x20 != 1, trap did not fire
    j       exit

.align 4
#   Trap Handler
trap_handler:
    csrr    x7, mcause              // Read trap cause
    li      x20, 1                  // Set flag: Trap entered

#   Self-check 2: Verify it is an Exception (MSB=0)
    srli    x12, x7, 63
    bne     x12, x0, fail           // If MSB=1 (Interrupt), fail

#   Self-check 3: Verify Cause is Illegal Instruction (Cause 2)
    li      x12, 2
    csrr    x7, mcause
    bne     x7, x12, fail           // If mcause != 2, fail

    csrr    x8, mepc
    addi    x8, x8, 4               // Skip faulty instruction
    csrw    mepc, x8
    mret                            // Return to next instruction

exit:
    li      x22, 0x80000146
    csrw    mtvec, x22              // Restore trap vector to prevent loops
    nop
    nop

    RVTEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
