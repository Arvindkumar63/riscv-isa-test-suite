#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4


start:
li		x5, 0x0
csrr x4, mstatus
csrrs x8, mstatus, x5 // 0x0000000a00000080
nop
nop
csrr x11, mstatus
nop
csrw mstatus, x5		// 0x0000000a00000000
nop
nop
csrr x12, mstatus


    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

