
/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
Date:28/11/2025
Owner:
Testcase name:unknown_csr
Description:Mentioning all the unknown csr in spike
===========================================================*/
//Testcase writing section
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64M
RVTEST_CODE_BEGIN
  li gp, 3
  li x1,20
 
handler:
	la x5,m_call
	csrw mtvec,x5
start:
test1:
	//csrr x6,mtval2		//unknown csr
	nop
	nop
test2:
	csrr x7,mnscratch     // unknown_350 from spike side
	nop
	nop
test3:
	csrr x8,mnepc			// unknown_351 from spike side
	nop
	nop
test4:
	csrr x9,mncause		// unknown_352 from spike side
	nop
	nop
test5:
	csrr x10,mnstatus		// unknown_353 from spike side
	nop
	nop
test6:
	//csrr x21,minsret	//unknown csr
	nop
	nop
test7:
	csrr x22,mcycleh	
	nop
	nop
test8:
	//csrr x23,mstatush	//unknown csr
	nop
	nop
test9:
	//csrr x24,mncycle	//unknown csr
	nop
	nop
test10:
	//csrr x25,mstateen	//unknown csr
	nop
	nop
test11:
	//csrr x26,menvcfgh	//unknown csr
	nop
	nop
test12:
	//csrr x27,medelegh	//unknown csr
	nop
	nop
test13:
	//csrr x28,mconfigptr	//unknown csr
	nop
	nop
test14:
	//csrr x29,mseccfgh	//unknown csr
	nop
	nop
test15:
	csrr x30,minstreth	
	nop
	nop
test16:
	//csrr x31,mstateen0h	//unknown csr
	nop
	nop
test17:
	//csrr x16,menvcfg	//unknown csr
	nop
	nop
test18:
	//csrr x17,mseccfg	//unknown csr
	nop
	nop
 
	jal x0,exit
 
m_call:
	csrr x11,mcause
	csrr x12,mtval
	csrr x13,mepc
	addi x13,x13,4
	csrw mepc,x13
	mret
 
exit:
	nop
	li x19,0x80000004
	csrw mtvec,x19
TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END

