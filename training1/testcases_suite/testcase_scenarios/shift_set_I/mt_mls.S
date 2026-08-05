// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: More than Maximum Left Shift (shamt > 31)
// Description: simple testcases for sll, slli, sllw, slliw with shift behavior
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1 - sll with shamt=35 
test1:
  li x6, 1
  li x9, 35         // x9 register can store 32 bit number 
  sll x7, x6, x9 //x7=0x0000000800000000    
  li t0, 8
  # bne x7, t0, fail

// Test2 - slli with shamt=35 
test2:
  li x6, 2
  slli x7, x6, 35    // slli will work on both rv32i & rv64i aswell // x7= 0x0000001000000000

                           # Error: Improper shift amount
//slli x7, x6, 97  //7bit
// 
//slli x7, x6, 129  //8 bit 6th bit is 0
//
// slli x7, x6, 0xabd1    // Error: Improper shift amount (43985) 


// Test3 - sllw with shamt=35 (masked to 3), simple test
test3:
  li x6, 3
  li x9, 35//1_00011
  sllw x7, x6, x9    // x7= 0x0000000000000018 

li x9, 0xab1121ab1 // 36 bit
  sllw x7, x6, x9    //x7= 0x0000000000060000  

 
// Test4 - slliw with shamt=35 
test4:
  li x6, 4
  slliw x7, x6, 31// max shamt=12 bit we can give
   

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

