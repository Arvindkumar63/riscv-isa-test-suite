/*=========================================================== 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date        : 27-11-2025
Owner       : Sudeepta
Testcase    : tc_pmp_napot
 
Description :
=============================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3                        # Signature register

#-------------------------------------------------------------
# Install machine trap handler
#-------------------------------------------------------------
install_trap_handler:
	la   x31, m_trap_handler
	csrw mtvec, x31
    nop
start:
	nop
	csrr x5, mstatus           # Read mstatus
	li   x6, 0x800             # MIE bit mask (bit 11)
	or   x5, x5, x6
	csrw mstatus, x5

#-------------------------------------------------------------
# PMP Address Configuration (NAPOT Encoded)
#-------------------------------------------------------------
pmp_addr:
    nop
addr1:
    csrr x7,pmpaddr0
	li	 x8,0x80000000
	srli x8,x8,2
	li	 x9,0x7
	or	 x9,x9,x8
	csrw pmpaddr0,x7
addr2:
    csrr x7,pmpaddr1
	li	 x8,0x80002000
	srli x8,x8,2
	li	 x9,0x7
	or	 x9,x9,x8
	csrw pmpaddr1,x7
	

pmp_cfg:
	csrr x10,pmpcfg0
	li	 x11,0x0
	csrw pmpcfg0,x11
	li	 x11,0x1F
	csrw pmpcfg0,x11
	csrr x10,pmpcfg0
	
mode_change:
    la 	 x12,s_mode
	csrw mepc,x12

	mret
s_mode:
    la x13,inp_data
    lw x14,4(x13)
	sw x14,8(x13)
    lw x14,12(x13)
	sw x14,24(x13)
    lw x14,48(x13)
	sw x14,96(x13)
    lw x14,100(x13)
	sw x14,16(x13)
#-------------------------------------------------------------
#-------------------- Trap Handler ---------------------------
#-------------------------------------------------------------
m_trap_handler:
	csrr x25, mepc             # Read current EPC
	addi x25, x25, 4           # Skip the faulting instruction
	csrw mepc, x25
	mret

done:
	nop
	nop
	la x31,shakti_end
	csrw stvec,x31
    TEST_PASSFAIL

RVTEST_CODE_END
.data
RVTEST_DATA_BEGIN

inp_data:
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x584944fc

  TEST_DATA
RVTEST_DATA_END

