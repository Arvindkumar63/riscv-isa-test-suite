#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
    li x5, 0x00000001
    li x6, 0xFFFFFFFF
    bltu x5, x6, label1
    li x7, 100     # skipped
label1:
    li x8, 200

test2:
    li x5, 0xFFFFFFFF
    li x6, 0x00000001
    bltu x5, x6, label2
    li x9, 300     # should execute
label2:
    li x10, 400

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

