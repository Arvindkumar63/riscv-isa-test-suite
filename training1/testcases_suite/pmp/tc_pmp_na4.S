/*=========================================================== 
Copyright 2025 Scaledge India Pvt Ltd

Testcase Name  : tc_pmp_na4
Owner          : Sudeepta Panda
Date           : 28-11-2025

Description:
------------
This test verifies the RISC-V Physical Memory Protection (PMP)
using **NA4 addressing mode**, which protects exactly 4 bytes.

Two NA4 regions are configured:
  - Region 0 protects inp_data[0]   (word at offset 0)
  - Region 1 protects inp_data[1]   (word at offset 4)

S-mode is allowed:
  - Read both NA4-protected locations (load)
  - Write only into Region 1 (store)
  - Attempting write to Region 0 should generate a trap.

=============================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3

/*------------------------------------------------------------
  Install trap handler
------------------------------------------------------------*/
trap_handler:
    la   x31, m_trap_handler
    csrw mtvec, x31

/*------------------------------------------------------------
  Enable interrupts, etc.
------------------------------------------------------------*/
start:
    csrr x5, mstatus
    li   x6, 0x800            // Set MIE
    or   x5, x5, x6
    csrw mstatus, x5

/*------------------------------------------------------------
  PMP ADDRESS SETUP (NA4 MODE)
  NA4 region = exactly 4 bytes at (pmpaddr << 2)
------------------------------------------------------------*/

pmp_addr:

    # Region 0 
    la   x10, inp_data        // 0x80002000
    srli x10, x10, 2
    csrw pmpaddr0, x10

    # Region 1
    la   x11, inp_data
    addi x11, x11, 4
    srli x11, x11, 2
    csrw pmpaddr1, x11

     # Region 2
    li   x21, 0x80000190
   // addi x21, x21, 4
   // srli x21, x21, 2
    csrw pmpaddr2, x21
/*------------------------------------------------------------
  PMP CONFIGURATION
  A=10 → NA4
  R=1 W=1 X=0 → RW only (no execute)
  Encoding: RW A=10 = 0b0011_10 = 0x0E
------------------------------------------------------------*/

pmp_cfg:
    li x12, 0x00
    csrw pmpcfg0, x12       
    li x12, 0x171717          
    csrw pmpcfg0, x12

/*------------------------------------------------------------
  Move to S-mode cleanly and start NA4 test
------------------------------------------------------------*/
mode_change:
    la   x13, s_mode
    csrw mepc, x13
	la x14, inp_data
    mret

/*------------------------------------------------------------
  S-Mode Test Code
------------------------------------------------------------*/
s_mode:

   // la x14, inp_data

    /* LOAD inside NA4 Region 0 → allowed */
    lw x15, 0(x14)

    /* STORE inside NA4 Region 1 → allowed */
    sw x15, 4(x14)

    /* STORE inside NA4 Region 0 → should TRAP */
    sw x15, 0(x14)          // Expect trap

    j done

/*------------------------------------------------------------
  Machine Trap Handler
  Only expected trap: store to protected NA4 region
------------------------------------------------------------*/
m_trap_handler:
    csrr x20, mcause
    csrr x21, mepc

    /* Skip the faulting instruction */
    addi x21, x21, 4
    csrw mepc, x21

    mret

done:
    nop
    nop

    TEST_PASSFAIL

RVTEST_CODE_END

/*------------------------------------------------------------
  Data Section
------------------------------------------------------------*/
.data
RVTEST_DATA_BEGIN

inp_data:
  .word 0x11112222
  .word 0x33334444

  TEST_DATA

RVTEST_DATA_END

