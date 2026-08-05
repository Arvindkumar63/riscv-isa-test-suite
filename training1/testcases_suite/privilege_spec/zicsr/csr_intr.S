/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date: 26-11-2025
 
Owner: Arvind Kumar Kori
 
Testcase name: csr_intr
 
Description:
Multiple testcase written for checking the behaviour of "Zicsr", Extension for Control and Status Register (CSR) Instructions,
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3

# Zicsr testcases
#		TESTCASE 1 : CSRRW  (Read old mstatus into x3, write x0 --> no change)
tc1:
		csrrw x3,	mstatus,	x0
		li 	x5,	0x880
		nop
		nop
	
#		TESTCASE 2 : CSRRS  (Set bits in mstatus using x5)
tc2:
		//csrrsi x4, mstatus, 	0x880	// when i am setting the immediate more then 5 BIT then => 	Error: Improper CSRxI immediate (2048) 

#		Checking the csrrs instruction behaviour using mstatus register
		csrrs x4,	mstatus,	x5		// What value you are setting that will updated else everything as it is.
		nop
		nop

#		TESTCASE 3 : CSRRC  (Clear MPP bits using mask)
tc3:
#		Clearing the mpp bits only by using csrrc instruction and mstatus csr register
		li x8, 0x1800
		csrrc x6,	mstatus,	x8		// When particular bits is high at that particular bit will clear else everything will as it is.	
		addi	x6,	x6,		0		// checking the x6 value updation which is read by csrrc register => in x6 old value retained so we have to again read the mstatus value
#		Reading the updated mstatus register value
		csrr	x8,	mstatus
		nop
		nop

#		TESTCASE 4 : CSRRW write-only (rs1≠0, rd=x0)
tc4:
#		Only writing the value in the mstatus without reading CSR
		li		x3,	0xA00000088
		csrrw	x0,	mstatus,	x3
		csrr	x9,	mstatus
		nop
		nop

TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END

 
RVTEST_DATA_END

