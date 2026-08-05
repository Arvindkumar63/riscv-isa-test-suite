#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 4    # Total number of tests

# Helper: Load 32-bit float constant into FP register using int reg
# e.g., li a0, 0x3fc00000 ; fmv.w.x f1, a0  => f1 = 1.5

# ----------------------------
# Test 1: fadd.s 1.5 + 2.5 = 4.0
test1:
  li a0, 0x3fc00000     # 1.5
  fmv.w.x f1, a0
  li a1, 0x40200000     # 2.5
  fmv.w.x f2, a1
  fadd.s f3, f1, f2     # f3 = 4.0
  li a2, 0x40800000     # 4.0
  fmv.w.x f4, a2
  feq.s x5, f3, f4      # x5 = (f3 == 4.0) ? 1 : 0

# ----------------------------
# Test 2: fadd.s -1.0 + 1.0 = 0.0
test2:
  li a0, 0xbf800000     # -1.0
  fmv.w.x f1, a0
  li a1, 0x3f800000     # 1.0
  fmv.w.x f2, a1
  fadd.s f3, f1, f2     # f3 = 0.0
  li a2, 0x00000000     # 0.0
  fmv.w.x f4, a2
  feq.s x6, f3, f4      # x6 = (f3 == 0.0) ? 1 : 0

# ----------------------------
# Test 3: fsub.s 5.5 - 2.0 = 3.5
test3:
  li a0, 0x40b00000     # 5.5
  fmv.w.x f1, a0
  li a1, 0x40000000     # 2.0
  fmv.w.x f2, a1
  fsub.s f3, f1, f2     # f3 = 3.5
  li a2, 0x40600000     # 3.5
  fmv.w.x f4, a2
  feq.s x7, f3, f4      # x7 = (f3 == 3.5) ? 1 : 0

# ----------------------------
# Test 4: fsub.s -1.5 - 1.5 = -3.0
test4:
  li a0, 0xbfc00000     # -1.5
  fmv.w.x f1, a0
  li a1, 0x3fc00000     # 1.5
  fmv.w.x f2, a1
  fsub.s f3, f1, f2     # f3 = -3.0
  li a2, 0xc0400000     # -3.0
  fmv.w.x f4, a2
  feq.s x8, f3, f4      # x8 = (f3 == -3.0) ? 1 : 0

TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END

