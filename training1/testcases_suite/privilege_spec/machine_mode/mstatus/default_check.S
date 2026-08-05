///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          20-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: mcounteren_cycle_set 
/// Description:
/// This test clears mcounteren[0] = 1, then switches to U‑mode using MPP=01 + MRET.
/// After entering S mode, executing csrr xN, cycle must immediately clear and not raise an illegal‑instruction exception because CY=1 for U/S-mode access.
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
h:
la x5, handled
start: 
//	change mode from machine to u mode
	li x5, 0x800
//	set mpp bit [12:11] = 10 for mode switching 
	csrw mstatus, x5
		csrr x4, mstatus

//	store the trap handler 
	la x9, switch_m_to_s
		csrw mepc, x9
		csrr x1, mepc

li x3, 0

	csrw mcounteren, x3// so illigal exception not generate
	csrr x2, mcounteren
	csrr x5, mcycle


	mret	

switch_m_to_s:
	csrr x9, cycle


lebel:
	addi x6, x5, 2 



    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

















//
///*===========================================================
// 
//Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
// 
//Date:
// 
//Owner:
// 
//Testcase name:
// 
//Description:
// 
//===========================================================*/
// 
////Testcase writing section
// 
//#include "test_macros.h"
//#include "riscv_test.h"
// 
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
// 
//  li gp, 3
//
// 
//start: 
//
//csrr x5, mstatus		// check the default value of the mstatus register, x5 = 0x8000000a00000080
//li x7, 0xffffffffffffffff		
//csrw mstatus, x7		// check the which bits are writable in the mstatus register
//csrr x4, mstatus		// x4 = 0x8000000a007e79aa that means SIE, MIE, SPIE, MPIE, SPP, MPP, FS, MPRV, SUM , MXR, TVM, TW TSR, UXL, SXL, SD bits are writable
//
//TEST_PASSFAIL
// 
//RVTEST_CODE_END
// 
//  .data
// 
//RVTEST_DATA_BEGIN
//  TEST_DATA
// 
// 
//RVTEST_DATA_END
//
