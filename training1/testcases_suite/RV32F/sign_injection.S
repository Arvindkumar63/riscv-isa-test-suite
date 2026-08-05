// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        20-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  fp_sign_injection
// Description:  Test FSGNJ.S, FSGNJN.S, and FSGNJX.S behavior
//
// ===========================================================

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 5

# Load values into float registers
  la x4, pos_val         # 3.5
  flw f1, 0(x4)

  la x5, neg_val         # -2.75
  flw f2, 0(x5)
  la x5, inp_data
flw f9,0(x5)


# -------------------------------
# Test 1: FSGNJ.S → copy sign of rs2
test1:
  fsgnj.s f3, f1, f2     # f3 = 3.5 with sign of f2 → -3.5

test1a:

   fsgnj.s f10,f2,f9

fsgnj.s f11,f2,f1

# -------------------------------
# Test 2: FSGNJN.S → copy inverted sign of rs2
test2:

  fsgnjn.s f5, f1, f2    # f5 = 3.5 with inverted sign of f2 → +3.5

  test2a:
  fsgnjn.s f10,f2,f9

  fsgnjn.s f11,f2,f1

  

# -------------------------------
# Test 3: FSGNJX.S → XOR signs of rs1 and rs2
test3:
  fsgnjx.s f7, f1, f2    # sign(f1) ^ sign(f2) = 1 → -3.5

   test3a:
  fsgnjx.s f10,f2,f9

  fsgnjx.s f11,f2,f1

test4:

  fmv.s f2, f9            # f2 = -4.25 (bitwise copy)
 
  fneg.s f5, f9           # f4 = +4.25 (negate -4.25) 

fabs.s f6, f9         # f6 = +4.25 (absolute of -4.25)

TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

pos_val:     .float 3.5
neg_val:     .float -2.75

inp_data:     .float -4.25

TEST_DATA
RVTEST_DATA_END

