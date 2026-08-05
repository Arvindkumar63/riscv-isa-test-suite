
/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:
 
Owner:
 
Testcase name:
 
Description:
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3

 la x9, m_call
 csrw mtvec, x9

start: 

csrr x5, mstatus		// check the default value of the mstatus register, x5 = 0x8000000a00000080
li x11, 0x100800
csrw mstatus, x11		// set mpp bit 00 for supervisor mode shifting

la x3, s_mode
csrw mepc, x3

mret

s_mode:
//li x7, 0x100000		//  
//csrw mstatus, x7		// TVM bit set

csrr x4, satp		// going to read the satp csr 
li x7, 0x10
csrw satp, x7

jal x0,exit// going to write the satp csr
 
      

		////        trap handler control
m_call:
csrr x21,mcause
csrr x22,mepc
csrr x23,mtval
addi x22,x22,4
csrw mepc,x22
mret

exit:

nop
nop
li x24,0x80000004
csrw mtvec,x24
// exception trap_illegal_instruction, at 0x000000008000010e
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END

