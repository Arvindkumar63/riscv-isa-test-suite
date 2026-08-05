#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN


test1:
    li x5, 0       # loop counter
    li x6, 3       # loop target
    li x7, 0       # taken branch counter

loop1:
    beq x5, x6, exit1       # not taken until x5 == 3 (1 taken)
    addi x7, x7, 1          # count iterations
    addi x5, x5, 1
    jal x0, loop1           # unconditional jump back to loop1

exit1:
    li x8, 5
    li x9, 5
    beq x8, x9, next1       # taken (2nd taken)
    li x10, 999             # skipped
next1:

    li x11, 1
    li x12, 2
    beq x11, x12, not_taken1   # not taken
    li x13, 100

not_taken1:
    li x14, 0x1234
    li x15, 0x1234
    jalr x1, x14, 0          # store return addr
    beq x14, x15, third_taken  # taken (3rd taken)
    li x16, 1000

third_taken:
    jalr x0, x1, 0           # return

test2:
    li x17, 0
    li x18, 2
    li x19, 0

loop2:
    beq x17, x18, exit2      # taken on 3rd iteration
    addi x19, x19, 2
    addi x17, x17, 1
    jal x0, loop2

exit2:
    li x20, 1
    li x21, 2
    beq x20, x21, nt1        # not taken
    li x22, 77

nt1:
    li x23, 5
    li x24, 5
    beq x23, x24, label3     # taken
    li x25, 99

label3:
    li x26, 10
    li x27, 20
    beq x26, x27, nt2        # not taken
    li x28, 88

nt2:
    li x29, 123
    li x30, 123
    beq x29, x30, done       # taken
    li x31, 999

done:

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

