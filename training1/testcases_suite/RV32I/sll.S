#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN
//test the sll operations in different different test scenarios
test1:
  li x6, 1
  li x7, 1
  sll x8, x6, x7 //x8 = 2

test2:
  li x6, 0x12345678abcd1234
  li x7, 4
  sll x8, x6, x7//x8 = 0x23456780

test3:
  li x6, 0xFFFFFFFFFFFFFFFF
  li x7, 16
  sll x8, x6, x7//x8 = 0xFFFF0000

test5:
  li x6, 0x0
  li x7, 31
  sll x8, x6, x7 //x8 = 0

TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

