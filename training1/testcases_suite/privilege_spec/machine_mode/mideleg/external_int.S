/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
Date:2/12/2025
Owner:
Testcase name:external interrupt produce and delegation using and handling in s amode 
Description:
===========================================================*/
//Testcase writing section
#include "test_macros.h"
 
#include "riscv_test.h"
RVTEST_RV64M
 
RVTEST_CODE_BEGIN
  li gp, 3
 
  li x1,20
 

start:
	csrr x5,mideleg
	li x6,0xffffffff
	csrw mideleg,x6
	csrr x7,mstatus
	li x8,0x1
	slli x8,x8,3
	csrs mstatus,x8
 
	li x9,0x1
	slli x9,x9,11
	csrs mstatus,x9
 
	la x10,smode
	csrw mepc,x10
	mret
 
smode:
 li x1, 2
 csrrs x3, sstatus, x1

	la x12, trap_handler

	csrw stvec,x12

li x5, 0x200
csrrs x2, sip,x5
nop
nop
	csrrs x4, sie,x5
 .align 4
 jal x0, exit
trap_handler:
	csrr x14,scause
	csrr x16,stval
	csrr x15,sepc
	addi x15,x15,4
	csrw sepc,x15
li x15,0x0
	csrw sip,x15
	csrw sie,x15

	sret
 
 
 exit:
 nop
 nop

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
 
  TEST_DATA

RVTEST_DATA_END

