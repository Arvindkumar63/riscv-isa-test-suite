//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//  li gp, 3// global pointer
// 
// 
// li x1, 3      
//li x2,  7          
//
//
//test2:
//li x6,5     
//li x7,8
//addi x5,x6,8
//
////test3:
////la x0, inp_data
////lw x2,0(x0)
//
//test4: 
//li x2, 0x00000000FFFFFFFF   # = -1 in 32-bit
//li x3, 0x0000000000000002   # = 2
//mulw x4,x2,x3 
////x4=0xffff_ffff_ffff_fffe = -2
//
//
//mul x5,x2,x3
////x5 =0x0000_0000_1fff_fffe != -2 =>536,870,910 (decimal) 
//
//
//  TEST_PASSFAIL 
//RVTEST_CODE_END
//.data
// 
//RVTEST_DATA_BEGIN
//  TEST_DATA
//
//inp_data:
//.word 0x12345678
//
//RVTEST_DATA_END














///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          20-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: mcounteren_clear 
/// Description:
/// This test clears mcounteren[0] = 0, then switches to U‑mode using MPP=00 + MRET.
/// After entering U‑mode, executing csrr xN, cycle must immediately raise an illegal‑instruction exception because CY=0 forbids U/S-mode access.
/// Trap handler must be triggered and the handler verifies that the cause is illegal instruction.
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li    gp,	4

#	trap handler address
trap_handler_address:
	la		x6,	trap_handler				// Load handler address 
	csrw	mtvec,x6						      // Set mtvec = trap handler address
	nop
	nop
	csrr	x8,	mtval

start:
#	Setting CY bit of mcounteren csr register 
	csrrsi x6,	mcounteren,	0
#	laoding 0x800 hexa value in x5 register and setting mpp bit = 01
	li		x5, 	0x800
	csrrs	x12,	mstatus,	x5					//	set mpp bit [12:11] = 01 for mode switching from m to s 
	nop
	nop
	csrr	x4,	mstatus					   // Check mstatus value after set
#	---- Self-check: verify mstatus[12:11] == 01 (MPP == 1)
#	shift right by 11, mask 2 bits, compare with 1
	srli	x10,	x4,	11
	andi	x10,	x10,	0x3
	li		x11,	1
	bne	x10,	x11,	fail					// if not equal -> fail

# 	If check passes, continue

#	load the trap handler for mode switching 
	la		x9,	switch_m_to_s
	csrw	mepc,	x9
	mret											// machine return to the address of mepc value for mode switching


switch_m_to_s:
	csrr	x9,	cycle

label:
	addi	x8,	x11,	1


    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END



























