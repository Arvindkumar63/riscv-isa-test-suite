///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          19-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: meie_disable 
/// Description:
/// This test verifies that the machine external  Interrupt is triggered only when all required conditions are satisfied:
/// mstatus[1] = 1 (MIE)
/// mideleg[11] = 0
/// mie[11] = 1 
/// mip[11] = 1 
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start: 
 
	li x13, 0xffffffffffffffff		// overflow condition

	csrr x2, mhpmevent3	
	csrr x3, mhpmevent4	
	csrr x4, mhpmevent5	
	csrr x5, mhpmevent10	
	csrr x6, mhpmevent15	
	
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret

	csrw mhpmevent3, x13 
	csrw mhpmevent4, x13 
	csrw mhpmevent5, x13 
	csrw mhpmevent10, x13 
	csrw mhpmevent15, x13 
	
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret

	csrr x2, mhpmevent3	
	csrr x3, mhpmevent4	
	csrr x4, mhpmevent5	
	csrr x5, mhpmevent10	
	csrr x6, mhpmevent15	


	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret
	csrw  mhpmcounter3 , x13  
	csrw  mhpmcounter4 ,x13
	csrw  mhpmcounter5, x13
	csrw  mhpmcounter10 , x13
	csrw   mhpmcounter15, x13


	csrr x22,  mhpmcounter3  
	csrr x23,  mhpmcounter4 
	csrr x24,  mhpmcounter5
	csrr x25,  mhpmcounter10
	csrr x26,   mhpmcounter15
	csrr x27,   mhpmcounter31
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret
	csrw mcycle, x13

	csrr x26, mcycle

lebel1:
//	for cycle counter enable 
	li x13, 0x10

	csrr x2, mhpmevent3	
	csrr x3, mhpmevent4	
	csrr x4, mhpmevent5	
	csrr x5, mhpmevent10	
	csrr x6, mhpmevent15	
	
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret

	csrw mhpmevent3, x13 
	csrw mhpmevent4, x13 
	csrw mhpmevent5, x13 
	csrw mhpmevent10, x13 
	csrw mhpmevent15, x13 
	
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret

	csrr x2, mhpmevent3	
	csrr x3, mhpmevent4	
	csrr x4, mhpmevent5	
	csrr x5, mhpmevent10	
	csrr x6, mhpmevent15	


	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret
	csrw  mhpmcounter3 , x13  
	csrw  mhpmcounter4 ,x13
	csrw  mhpmcounter5, x13
	csrw  mhpmcounter10 , x13
	csrw   mhpmcounter15, x13


	csrr x22,  mhpmcounter3  
	csrr x23,  mhpmcounter4 
	csrr x24,  mhpmcounter5
	csrr x25,  mhpmcounter10
	csrr x26,   mhpmcounter15
	csrr x27,   mhpmcounter31
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret
	csrw mcycle, x13

lebel2:
//	for cycle counter enable 
	li x13, 0x0000000000000020
	csrr x2, mhpmevent3	
	csrr x3, mhpmevent4	
	csrr x4, mhpmevent5	
	csrr x5, mhpmevent10	
	csrr x6, mhpmevent15	
	
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret

	csrw mhpmevent3, x13 
	csrw mhpmevent4, x13 
	csrw mhpmevent5, x13 
	csrw mhpmevent10, x13 
	csrw mhpmevent15, x13 
	
	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret

	csrr x2, mhpmevent3	
	csrr x3, mhpmevent4	
	csrr x4, mhpmevent5	
	csrr x5, mhpmevent10	
	csrr x6, mhpmevent15	


	csrr x23, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret
	csrw  mhpmcounter3 , x13  
	csrw  mhpmcounter4 ,x13
	csrw  mhpmcounter5, x13
	csrw  mhpmcounter10 , x13
	csrw   mhpmcounter15, x13
	csrw   mhpmcounter31, x13


	csrr x22,  mhpmcounter3  
	csrr x23,  mhpmcounter4 
	csrr x24,  mhpmcounter5
	csrr x25,  mhpmcounter10
	csrr x26,   mhpmcounter15
	csrr x27,   mhpmcounter31
	csrr x28, cycle

	csrr x23, mcycle

	csrr x23, instret

	csrr x23, minstret
//	csrw mcycle, x13


    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
