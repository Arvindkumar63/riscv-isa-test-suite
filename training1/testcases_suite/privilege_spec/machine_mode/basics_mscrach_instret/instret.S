/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
Date:
Owner:
Testcase name:instret
Description:this test is to verify ,when cycle bit is disabled in scounteren,read instret in user mode, verify whether illegal exception is raised or not.
===========================================================*/
//Testcase writing section
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M
RVTEST_CODE_BEGIN
  li gp, 3
  li x1,20
 

start: 
	la x5,m_trap_handler	#trap handler setup
	csrw mtvec,x5
 
	li x23,0x800			#mstatus.mpp[12:11]=01 mode change to machine to supervisor
	csrr x24,mstatus
	or x24,x23,x24
	csrw mstatus,x24
	la x26,s_mode
	csrw mepc,x26
	mret
 
s_mode:
 
 
	csrr x6,scounteren
	li x7,0x4
	li x20,0x2
	csrc scounteren,x7		#scounter.tm[1]=0
 
	li x8,0x100
	csrr x9,sstatus
	or x9,x8,x9
	csrw sstatus,x9			#sstatus.spp[8]=0 mode change supervisor to user
 
	la x10,u_mode
	csrw sepc,x10
	sret
 
u_mode:
	add x11,x8,x7
	csrr x12,instret		#read instret will trigger an illegal exception
 
s_trap_handler:
	csrr x15,scause
	bne x15,x20,fail
	beq x15,x20,check_pass
	csrr x16,sepc
	addi x16,x16,4
	csrw sepc,x16
	sret
 
m_trap_handler:
	csrr x15,mcause
	bne x15,x20,fail
	beq x15,x20,check_pass
	csrr x16,mepc
	addi x16,x16,4
	csrw mepc,x16
	mret
 
check_pass:
	nop
	nop
	li x21,0x80000004
	csrw mtvec,x21
 
 
TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
