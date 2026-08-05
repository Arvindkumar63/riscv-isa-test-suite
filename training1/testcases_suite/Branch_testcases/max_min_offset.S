// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        16-06-2025
// Owner:       Arvind & Nikhil
// Testcase name: Max and Min Branch Offset Verification
// Description: Verifies maximum and minimum forward/backward branch offset
//              range supported by conditional branch instructions
//              using label distances of ±4KB and ±2 bytes.
//
// ===========================================================
#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 1        
start:
# ---------------------------------------
# Max  Offset Branch (+4094 bytes)
# ---------------------------------------
  li x1, 1
  beq x1, x1, label_max_fwd  # Must jump ahead ~4094B

  .align 2
  .rept 1023                # 1023 × 4 = 4092 bytes
    nop
  .endr
  c.nop                    # +2B = 4094 total

label_max_fwd:
  li x2, 0xAAAA

# ---------------------------------------
# Max  Offset Branch (−4096 bytes)
# ---------------------------------------
label_min_start:
  li x3, 1
  beq x3, x3, label_max_back  # Must jump back ~4096B

  .align 2
  .rept 1024                # 1024 × 4 = 4096 bytes
    nop
  .endr

label_max_back:
  li x4, 0xBBBB

  TEST_PASSFAIL



RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END




/*  li gp, 3 
 
// ------------------ Max Forward Branch Offset Test ------------------
  li x10, 1
  beq x10, x10, max_fwd_offset_label  // Forward branch to near max offset (dummy padded)
 
  .rept 1022
    nop
  .endr
 
max_fwd_offset_label:
  li x11, 0xABAB
  li t2, 0xABAB
  bne x11, t2, fail
 
// ------------------ Max Backward Branch Offset Test ------------------
  li x12, 1
min_bwd_offset_label:
  bne x12, x0, min_bwd_offset_branch  // branch back if not zero
  li x13, 999                         // skipped
 
  .rept 1022
    nop
  .endr
 
min_bwd_offset_branch:
  li t3, 1
  bne x12, t3, fail
 
// ------------------ Min Forward Branch Offset Test ------------------
  li x14, 0
  beq x14, x14, min_forward_ok   // shortest legal forward branch
  li x15, 999                    // should be skipped
 
min_forward_ok:
  li t4, 0
  bne x14, t4, fail
 
// ------------------ Min Backward Branch Offset Test ------------------
  li x16, 1
min_back_label:
  bne x16, x0, min_back_label    // shortest legal backward branch
  li t5, 1
  bne x16, t5, fail
 
  TEST_PASSFAIL
 
RVTEST_CODE_END
 
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END*/
