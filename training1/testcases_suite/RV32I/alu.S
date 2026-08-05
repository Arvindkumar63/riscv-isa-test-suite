

#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


testcase1:
# Testcase 1: ALU Arithmetic and Logical Operations

# Register to Register Addition
li x6, 50          # x6 = 50
li x7, 50          # x7 = 50
add x8, x6, x7     # x8 = x6 + x7 = 100

# Register to Immediate Addition
li x6, 20          # x6 = 20
addi x7, x6, 30    # x7 = x6 + 30 = 50

# Shift Logical Left
li x6, 5           # x6 = 5
li x7, 2           # x7 = 2
sll x8, x6, x7     # x8 = x6 << x7 = 20

# Bitwise OR
addi x6, zero, 4   # x6 = 4
addi x7, zero, 1   # x7 = 1
or x8, x6, x7      # x8 = x6 | x7= 5


testcase2:
# Testcase 2: Factorial Using Loop (x6 > 1)

# Assume x6 contains the number for which factorial is to be calculated
addi x6, zero, 1   # x6 = 1 (product)
addi x7, zero, 1   # x7 = 1 (counter)

loop:
    mul x6, x6, x7     # x6= x6 * x7
    addi x7, x7, 1     # x7 = x7 + 1
    bge x8, x7, loop   # repeat if x7 <= x8


TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
    TEST_DATA



inp_data:
  .word 0x06627912
  .word 0x06627912
  .word 0x584944fc
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
  .word 0x2a9e3a3d
  .word 0x2a9e3a3d
  .word 0x59f86117
  .word 0x59f86117
  .word 0x39214611
  .word 0x39214611
  .word 0x6ec633f5
  .word 0x6ec633f5
  .word 0x4910a7b3
  .word 0x4910a7b3
  .word 0x3392ec72
  .word 0x3392ec72
  .word 0x6c3af175
  .word 0x6c3af175
  .word 0x74555adb
  .word 0x74555adb
  .word 0x360a50f7
  .word 0x360a50f7
  .word 0x39febbec
  .word 0x39febbec
  .word 0x28cb8c74
  .word 0x28cb8c74

RVTEST_DATA_END
