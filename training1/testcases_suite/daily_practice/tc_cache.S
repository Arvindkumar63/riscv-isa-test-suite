// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd
// Date:        18-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  TC_CACHE_PIPELINE_MEMORY
// Description:   Pipeline-style memory access to test cache behavior
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 1        

 test1:
  la t0, test_data // Base address of memory
  li t1, 0         // Offset
  li t2, 8         // Stride (simulate cache block skip)
  li t3, 5         // Loop count

loop:
  ld t4, 0(t0)     // Load 1st word — should cause MISS first time
  add t0, t0, t2   // Increment to next block (simulate stride access)
  addi t1, t1, 1
  bne t1, t3, loop // Loop for several accesses

  // Now reaccess same addresses (simulate cache HIT if cache working)
  la t0, test_data
  li t1, 0
  li t3, 5
loop2:
  ld t5, 0(t0)     // Should hit now if cache holds the lines
  add t0, t0, t2
  addi t1, t1, 1
  bne t1, t3, loop2

  li gp, 2         // Indicate test passed

TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  .align 3
test_data:
  .dword 0xDEADBEEFCAFEBABE
  .dword 0x1122334455667788
  .dword 0x0102030405060708
  .dword 0xAABBCCDDEEFF0011
  .dword 0xFACEFEEDDEADC0DE
RVTEST_DATA_END

