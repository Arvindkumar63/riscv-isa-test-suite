#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 4       

# Load inputs: rs1 = 2.0, rs2 = 3.0, rs3 = 1.0
  la x4, val2
  flw f1, 0(x4)        # f1 = 2.0
  la x5, val3
  flw f2, 0(x5)        # f2 = 3.0
  la x6, val1
  flw f3, 0(x6)        # f3 = 1.0

# Test 1: fmadd.s → (2.0 * 3.0) + 1.0 = 7.0
test1:
  fmadd.s f4, f1, f2, f3
  la x7, exp_7
  flw f5, 0(x7)

# Test 2: fmsub.s → (2.0 * 3.0) - 1.0 = 5.0
test2:
  fmsub.s f6, f1, f2, f3
  la x7, exp_5
  flw f7, 0(x7)

# Test 3: fnmsub.s → -(2.0 * 3.0) + 1.0 = -5.0
test3:
  fnmsub.s f8, f1, f2, f3
  la x7, exp_n5
  flw f9, 0(x7)

# Test 4: fnmadd.s → -(2.0 * 3.0) - 1.0 = -7.0
test4:
  fnmadd.s f11, f1, f2, f3
  la x7, exp_n7
  flw f12, 0(x7)

//advantages of the fused instructions
test5:
la x5, val2
la x6,val3
flw f1,0(x5)
flw f2,0(x6)
fmadd.s f7,f1,f2,f2 # f7=0xffffffff41100000  === 9.0 => more precise
fmul.s f5,f1,f2
fadd.s f7,f2,f2  # f7= 0xffffffff40c00000   === 6.0  => less precise


TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

val1:     .float 1.0
val2:     .float 2.0
val3:     .float 3.0

exp_7:    .float 7.0
exp_5:    .float 5.0
exp_n5:   .float -5.0
exp_n7:   .float -7.0

TEST_DATA
RVTEST_DATA_END

