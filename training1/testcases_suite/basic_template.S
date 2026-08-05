/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:
 
Owner:
 
Testcase name:
 
Description:
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
 
start: 


TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END

