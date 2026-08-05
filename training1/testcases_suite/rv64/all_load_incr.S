
#include "test_macros.h"
#include "riscv_test.h"



RVTEST_RV64M
RVTEST_CODE_BEGIN



  li gp, 3
start:
la x6, inp_data 

    li x5, 0                // running offset


// Tests — LB + LBU 

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




test3:
    add x7, x6, x5
    lw  x12, 0(x7)
    addi x5, x5, 4

    add x7, x6, x5
    lw  x12, 0(x7)
    addi x5, x5, 4

//RV64 only

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


// RV64 only

test5:
    add x7, x6, x5
    ld  x14, 0(x7)
    addi x5, x5, 8


  TEST_PASSFAIL



RVTEST_CODE_END



.data
RVTEST_DATA_BEGIN
inp_data:
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
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  TEST_DATA
RVTEST_DATA_END




