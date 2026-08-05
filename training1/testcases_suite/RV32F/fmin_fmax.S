#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 4       

# --------------------
# Test 1: fmin.s (+1.5, +2.5) → expect 1.5
test1:
  la x4, val1_5
  flw f1, 0(x4)
  la x5, val2_5
  flw f2, 0(x5)
  fmin.s f3, f1, f2

# Test 2: fmin.s (+0.0, -0.0) → expect -0.0
test2:
  la x4, pos_zero
  flw f1, 0(x4)
  la x5, neg_zero
  flw f2, 0(x5)
  fmin.s f3, f1, f2


# --------------------
# Test 3: fmax.s (1.1, -1.1) → expect 1.1
test3:
  la x4, val1_1
  flw f1, 0(x4)
  la x5, val_neg1_1
  flw f2, 0(x5)
  fmax.s f3, f1, f2

# Test 4: fmax.s (+0.0, -0.0) → expect +0.0
test4:
  la x4, pos_zero
  flw f1, 0(x4)
  la x5, neg_zero
  flw f2, 0(x5)
  fmax.s f3, f1, f2

TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

val1_5:       .word 0x3FC00000   # 1.5
val2_5:       .word 0x40200000   # 2.5
val1_1:       .word 0x3F8CCCCD   # 1.1
val_neg1_1:   .word 0xBF8CCCCD   # -1.1
pos_zero:     .word 0x00000000   # +0.0
neg_zero:     .word 0x80000000   # -0.0

TEST_DATA
RVTEST_DATA_END

