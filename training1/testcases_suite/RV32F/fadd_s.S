#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF        # Use RV64 + F (single-precision float)
RVTEST_CODE_BEGIN

  li gp, 2           # Number of tests

# Test 1: fadd.s simple case: 1.5 + 2.5 = 4.0
test1:
    la t0, val1
    flw f1, 0(t0)
    la t1, val2
    flw f2, 0(t1)
    fadd.s f3, f1, f2
    la t2, expected1
    flw f4, 0(t2)
    feq.s x5, f3, f4     # Check if f3 == expected1

# Test 2: Corner case: -1.0 + 1.0 = 0.0
test2:
    la t0, val3
    flw f1, 0(t0)
    la t1, val4
    flw f2, 0(t1)
    fadd.s f3, f1, f2
    la t2, expected2
    flw f4, 0(t2)
    feq.s x6, f3, f4     # Check if f3 == expected2

TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA

val1:       .float 1.5
val2:       .float 2.5
expected1:  .float 4.0

val3:       .float -1.0
val4:       .float 1.0
expected2:  .float 0.0

RVTEST_DATA_END

