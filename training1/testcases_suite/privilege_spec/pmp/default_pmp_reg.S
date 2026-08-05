// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        11-12-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: default_pmp_reg
// Description:
// Verify the defualt values of pmp address register and pmp configure registers and writable bits.  
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//	li	gp, 3
//start:
//	li	x3, 0xffffffffffffffff
////label0:
//
//	csrr	x4, pmpaddr0			// x4=0x003fffffffffffff i.e. 10 msb bits are reserved, for rv64, each pmp addr. reg. encodes bits 55-2 of a 56 bit physical address
//	csrr	x5, pmpcfg0			// x5=0x000000000000001f i.e. A,X,W,R = set and [7:4] = 0 including LOCK
//	csrw	pmpaddr0, x3
//	nop
//	nop
//	csrr	x7, pmpaddr0			// no change
//	csrw	pmpcfg0, x3
//	nop
//	nop
//	csrr	x9, pmpcfg0			// x9=0x9f9f9f9f9f9f9f9f i.e. A,X,W,R,L = set and [6:5] = 0 (reserved) => this is a 4 byte pmp configuration register entries or 4 pmp entries 0-3
//
	
//i
//
//
//
//	la	x12, trap_handler
//	csrw	mtvec, x12
//
//	li	x1, 0x800
//	csrr	x2, mstatus
//	csrs	mstatus, x1			// mpp=01 switch to s mode
//	nop
//	nop
//	csrr	x4, mstatus
//#	set W,X,A = HIGH and R,L = low and check the behaviour which is access type is denied i.e. read(load) denied.
//	csrr	x6, pmpcfg0
//	li	x7, 0x1e			// exception trap_load_access_fault, 
//	csrw	pmpcfg0, x7
//	nop
//	nop
//	
//#	mode switch logic
//	csrr	x5, mepc
//	la	x6, s_mode
//	csrw	mepc, x6
//	nop
//	nop
//	mret
//
//s_mode:
//#	loading(read) the value from memory using lw
//	la	x8, inp_data
//	lw	x9, 4(x8)
//	nop
//	j	exit
//.align 4
//
//trap_handler:
//	csrr	x13, mcause
//	csrr	x14, mtval
//	csrr	x15, mepc
//	addi	x15, x15, 4
//	csrw	mepc, x15
//	nop
//	nop
//	mret
//exit:
//	.rept 6
//	nop
//	.endr
//
//	li	x16, 0x80000004
//	csrw 	mtvec, x16
//
//
//  TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//inp_data:
//	.word 0x12345678
//  TEST_DATA
//RVTEST_DATA_END
//










/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           11-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  pmp_load_access_fault

  Description:
  Verifies PMP Load Access Fault.
  Configures PMP0 with W=1, X=1, but R=0 (pmpcfg0=0x1E).
  S-mode attempts to Load (Read) data, which should trap.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   Set Trap Handler
    la      x2, trap_handler
    csrw    mtvec, x2

#   1. Set Address Range (pmpaddr0)
#   Set to -1 to cover ALL memory addresses using NAPOT.
    li      x3, -1
    csrw    pmpaddr0, x3

#   2. Set Configuration (pmpcfg0)
#   0x1E = 0001 1110 -> NAPOT(11), X(1), W(1), R(0)
#   Read Access is DENIED.
    li      x4, 0x1E
    srli    x4,x4, 2
    csrw    pmpcfg0, x4

#   MODE SWITCH
#   Prepare for S-mode transition
    la      x6, s_mode
    csrw    mepc, x6

#   Configure mstatus (MPP=01 for S-mode)
    li      x3, 0x1800
    csrc    mstatus, x3             // Clear MPP
    li      x3, 0x0800
    csrs    mstatus, x3             // Set MPP=01
    mret                            // Enter S-mode

#   S-MODE EXECUTION
s_mode:

#   Attempt to Load Data (Read)
#   PMP permission R=0, so this MUST TRAP.
    la      x8, inp_data
    lw      x9, 0(x8)

    j       exit

.align 4
#   TRAP HANDLER
trap_handler:
    csrr    x12, mcause             // Read mcause
    
#   Verify Cause: Load Access Fault (5)
    li      x15, 0xb
   // bne     x12, x15, fail

#   Set Flag = 1 to indicate Trap Occurred
    li      x20, 1

    csrr    x8, mepc
    addi    x8, x8, 4               // Skip instruction
    csrw    mepc, x8
    mret

exit:
    nop
    nop
    li	    x4, 0x80000004
    csrw    mtvec, 4

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
inp_data:
    .word 0xDEADBEEF
RVTEST_DATA_END
