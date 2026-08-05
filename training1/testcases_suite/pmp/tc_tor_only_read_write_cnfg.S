/*=========================================================== 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:27-11-2025
 
Owner: Sudeepta
 
Testcase name:tc_tor_only_write_cnfg 
 
Description:reset the configuration and provide access for read and execute 
perform read, write and execute in tor. 
  
=============================================================*/
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
	nop
	csrr x22,mstatus
	li x23,0x800
	or x22,x22,x23
	csrw mstatus,x22

pmp_addr:
	csrr x12,pmpaddr0
	li x5,0x80003000
	srli x21,x5,2
	csrw pmpaddr0,x21

pmp_cfg:
	csrr x2,pmpcfg0
	li x20,0x00000000
	csrw pmpcfg0,x20
	li x3,0xB			
	csrw pmpcfg0,x3
	csrr x2,pmpcfg0

mode_change:
    la   x24, s_mode
    csrw mepc, x24
    mret				#trap

s_mode:
	la x6,inp_data
	//lw x10,0(x6)
	sw x10,4(x6)			#can't perform read,write without execute
	lw x10,0(x6)
done:
	nop
	nop
  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
inp_data:
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  TEST_DATA
RVTEST_DATA_END






