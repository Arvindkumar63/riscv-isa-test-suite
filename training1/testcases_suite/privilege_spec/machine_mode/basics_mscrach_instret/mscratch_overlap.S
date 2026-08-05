/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
Date:
Owner:ARVIND KUMAR KORI
Testcase name:mscratch_overlap
Description:The register value will not change due to exception, 
			In order to prevent overwrite and lose of the previous values, when a supervisor  mode trap handler is entered ,the old value of sscratch will remain same.
===========================================================*/
//Testcase writing section
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M
RVTEST_CODE_BEGIN
  li gp, 3
  li x1,20
 
handler:
	la x6,m_call	#traphandler setup
	csrw mtvec,x6
start:
 
	li x5,0x12345678	#write a value to mscratch
	csrw mscratch,x5
	li x27,0x3
 
	ebreak				#trigger a exception
	nop
	addi x5,x5,4
	addi x5,x5,4
	csrr x8,mscratch	#after returning from the trap read from different the value will not be changed
 
	beq x10,x27,check_pass	#self check for pass
	bne x10,x27,check_fail	#self check for fail
 
.align 4
m_call:
	csrr x10,mcause
	bne x10,x27,fail
	csrr x11,mepc
	csrr x12,mtval
	addi x11,x11,2
	csrw mepc,x11
	mret
 
check_fail:
	nop
	nop
 
check_pass:
	nop
	nop
	li x15,0x80000004
	csrw mtvec,x15 
TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
