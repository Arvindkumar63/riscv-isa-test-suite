/// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        08-09-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: MSTATUS Register Read/Write
// Description: 
//   1. Read default value of mstatus and verify MIE bit
//   2. Write a new value (supervisor mode) and read back
//   3. Write WPRI (Write-Preserve, Read-Ignore) bits and check behavior
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN
  
  li    gp, 3          
  li    x1, 20         
  li    x6, 0x800      
  li    x8, 0x7FFFFFC07F800815 // WPRI test pattern for mstatus

level1:

  // -----------------------------------------------------------
  // 1. Read DEFAULT value of mstatus
  // -----------------------------------------------------------
  csrr  x7, mstatus           // x7 =0x0000000A00000080

l2:
  // -----------------------------------------------------------
  // 2. Check MIE (Machine Interrupt Enable) bit
  // -----------------------------------------------------------
  andi  x7, x7, 0x80          // Mask only MIE bit (bit 7)
  // If MIE=1 => x7 = 0x80
  // If MIE=0 => x7 = 0x00
 
l3:
  // -----------------------------------------------------------
  // 3. Write mstatus with supervisor mode value
  // -----------------------------------------------------------
  csrw  mstatus, x6          
  csrr  x11, mstatus           
  // Here, x11 should match 0x800 or reflect allowed bits only

l4:
  // WPRI = Write Preserve, Read Ignore
  // Writing undefined bits should not affect reserved bits
  csrw  mstatus, x8            
  csrr  x12, mstatus

l5:     
//example
li   x8, 0xFFFFFFFFFFFFFFFF   // Attempt to write all 1scsrw mstatus, x8           
csrw mstatus, x8           //the hardware only keeps legal bits.=

csrr x12, mstatus              // Read back into x12=0x8000000a007e79aa


  TEST_PASSFAIL                

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
  TEST_DATA                     
RVTEST_DATA_END

