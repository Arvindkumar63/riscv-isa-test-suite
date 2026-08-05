// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        20-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  SQRT
// Description:  Test all corner cases 1) 4 2)5 3) 5.77 4) 0.0 5) -1.0 6) NaN 
//
// ===========================================================


#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 6

# --------------------------
test1:
# Test 1: sqrt(4.0) → 2.0
  la x4, val_4
  flw f1, 0(x4)
  fsqrt.s f2, f1

# --------------------------
test2:
# sqrt(5.0) → ≈ 2.236068
  la x4, val_5
  flw f1, 0(x4)
  fsqrt.s f2, f1

# --------------------------
test3:
# sqrt(5.77) → ≈ 2.402
  la x4, val_5_77
  flw f1, 0(x4)
  fsqrt.s f2, f1

 # --------------------------
test4:
# sqrt(0.0) → 0.0
  la x4, val_0
  flw f1, 0(x4)
  fsqrt.s f2, f1

# --------------------------
test5:
# sqrt(-1.0) → should raise Invalid Op, result is NaN
  la x4, val_neg1
  flw f1, 0(x4)
  fsqrt.s f2, f1
 
# --------------------------
test6:
# sqrt(NaN) → NaN, no exception
  la x4, val_nan
  flw f1, 0(x4)
  fsqrt.s f2, f1

  TEST_PASSFAIL


RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

val_4:          .float 4.0
exp_2:          .float 2.0

val_5:          .float 5.0
exp_sqrt5:      .float 2.236067

val_5_77:       .float 5.77
exp_sqrt5_77:   .float 2.402081

val_0:          .float 0.0
val_neg1:       .float -1.0

val_nan:        .word 0x7FC00000   # Quiet NaN in IEEE 754

TEST_DATA
RVTEST_DATA_END























//Notes:
//Raises the invalid operation exception if the input is negative (excluding -0.0).
//
//Square root of NaN returns NaN (no exception).
//
//Rounding mode is used, but typically default (nearest-even).
//
//Operates only on single-precision floats (.s).
