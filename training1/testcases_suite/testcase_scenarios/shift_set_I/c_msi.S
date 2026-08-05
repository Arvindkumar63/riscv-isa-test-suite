// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: Comparison with Maximum Signed Integer
// Description: Test compare instructions involving maximum signed integer 0x7FFFFFFF
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1: slt with max signed int (0x7FFFFFFF)
test1:
  li x6, 0x7FFFFFFF
  li x5, -1
  slt x7, x5, x6      // -1 < max_int? should be 1
  li t0, 1
  bne x7, t0, fail

//test: maximum signed 12 bit immediate we have to use then it will not give error= 11bit we can use but 12th bit for sign extenstion

test:
  li x6, -1
  slti x7, x6,0x7ff 



// Test2: slti with max signed int immediate
                         //  Error: illegal operands # why=> that violate the RISC-V ISA rules or the specific core’s implementation limits.
//Meaning: Instruction exists, but you used it incorrectly — wrong register types, bad immediate, or wrong operand count.

                         // Error: unrecognized opcode # Meaning: You used an instruction that doesn’t exist in the RISC-V spec or isn't supported in your build. (cause = typo in the instruction)

#                                          slli x5, x6, x7   # (Error: Instruction slli requires absolute expression)=> why this bcz slli is a valid opcode but x7 invalid
#                                           slli x5,x6 x7  # illegal operands — slli expects an immediate 
#                                          srll x5, x6, 5    # unrecognized opcode — 'srll' is not a valid instruction
#                                          slll x5, x6 5  # unrecognized opcode — 'srll' is not a valid ( first check instr.(opcode) then check operands) 





//test2:
//  li x6, -1
//  slti x7, x6, 0x7FFFFFFF  // -1 < max_int? should be 1


// Test3: sltu unsigned compare with max signed int

     //  Error: illegal operands 
//test3:
//  li x6, 0x7FFFFFFF
//  li x5, 0xFFFFFFFF
//  sltu x7, x6, x5      // max_int < unsigned -1? should be 1


// Test4: sltiu with immediate max signed in  
   //  Error: illegal operands   
//test4:
//  li x6, 0
//  sltiu x7, x6, 0x7FFFFFFF  // 0 < max_int (unsigned)? should be 1


  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

