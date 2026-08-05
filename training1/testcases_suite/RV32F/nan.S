#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li gp, 2

start:
la x6, inp_data 

    li x5, 0                // running offset


// Test 1 — LB + LBU (3 times, +1 increment)

test1:
    add x7, x6, x5
    lb  x8, 0(x7)
    lbu x9, 0(x7)
    addi x5, x5, 1          // increment by 1 byte

    add x7, x6, x5
    lb  x8, 0(x7)
    lbu x9, 0(x7)
    addi x5, x5, 1

    add x7, x6, x5
    lb  x8, 0(x7)
    lbu x9, 0(x7)
    addi x5, x5, 1


// Test 2 — LH + LHU (3 times, +2 increment)

    add x7, x6, x5
    lh  x10, 0(x7)
    lhu x11, 0(x7)
    addi x5, x5, 2

    add x7, x6, x5
    lh  x10, 0(x7)
    lhu x11, 0(x7)
    addi x5, x5, 2

    add x7, x6, x5
    lh  x10, 0(x7)
    lhu x11, 0(x7)
    addi x5, x5, 2


// Test 3 — LW (3 times, +4 increment)

test3:
    add x7, x6, x5
    lw  x12, 0(x7)
    addi x5, x5, 4

    add x7, x6, x5
    lw  x12, 0(x7)
    addi x5, x5, 4

// Test 4 — LWU (3 times, +4 increment) — RV64 only

test4:
    add x7, x6, x5
    lwu x13, 0(x7)
    addi x5, x5, 4

    add x7, x6, x5
    lwu x13, 0(x7)
    addi x5, x5, 4

    add x7, x6, x5
    lwu x13, 0(x7)
    addi x5, x5, 4


// Test 5 — LD (3 times, +8 increment) — RV64 only

test5:
    add x7, x6, x5
    ld  x14, 0(x7)
    addi x5, x5, 8


    TEST_PASSFAIL
RVTEST_CODE_END


    .data


inp_data:
    .word 0xffffffff
    .word 0x5849446c
    .word 0x06625342
    .dword 0x1111111106627912
    .word 0x06627912
    .word 0x584944fc
    .word 0x558f5366
    .word 0x558f5366
    .word 0x29df2fb1
    .word 0x29df2fb1
    .word 0x40053e92
    .word 0x40053e92
    .word 0x17010699
    .word 0x17010699
    .word 0x594b9169
    .word 0x594b9169
    .word 0x64cd11c7
    .word 0x64cd11c7
    .word 0x6133a31e
    .word 0x6133a31e


TEST_DATA
RVTEST_DATA_END
