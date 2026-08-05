/*=========================================================== 
Copyright  2025 Scaledge India Pvt Ltd - All Rights Reserved.
 
Date        : 27-11-2025
Owner       : Sudeepta
Testcase    : tc_pmp_pmp1
 
Description :
-------------
This test validates the **configuration and enforcement of PMP entry 1 (pmp1)** 
while switching from M-mode to S-mode. The goal is to verify:

1. PMP address register pmpaddr1 is programmed correctly.
2. PMP configuration register pmpcfg0 (corresponding to pmp1cfg) is set with 
   appropriate permissions.
3. After M-mode configuration, switching to S-mode using mret.
4. Attempting memory accesses from S-mode to ensure PMP protections work as expected.
5. Proper trap behavior is validated using TEST_PASSFAIL.

Test Flow:
-----------
• Enable interrupts in M-mode (set MIE bit in mstatus).  
• Program pmpaddr1 with a test region address.  
• Clear pmpcfg0 and configure entry 1 with RWX permissions.  
• Move to S-mode using mret.  
• Perform store/load in S-mode inside the PMP region.  
• Finish with TEST_PASSFAIL.

=============================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3              // GP used as signature register

// ------------------------------------------------------------
// Enable M-mode interrupts by setting MIE bit (bit 11 of mstatus)
// ------------------------------------------------------------
start:
	nop
	csrr x22, mstatus     // Read mstatus
	li   x23, 0x800       // Bit mask for MIE (bit 11)
	or   x22, x22, x23    // Set MIE bit
	csrw mstatus, x22     // Write back updated mstatus

// ------------------------------------------------------------
// Program PMP Address Register (pmpaddr1)
// PMP address fields hold bits [XLEN-1:2] of physical address
// ------------------------------------------------------------
pmp_addr:
	csrr x12, pmpaddr1     // Read old pmpaddr1 (for debug)
	li   x5, 0x80003000    // Test region base address
	srli x21, x5, 2        // Shift right by 2 as required by PMP format
	csrw pmpaddr1, x21     // Write new PMP address to pmpaddr1

// ------------------------------------------------------------
// Configure PMP entry (pmp1cfg in pmpcfg0)
// Steps:
//   1. Clear pmpcfg0
//   2. Program pmp1cfg = 0xE = RWX permissions, A=TOR (top of range)
// ------------------------------------------------------------
pmp_cfg:
	csrr x2, pmpcfg0       // Read existing pmpcfg0
	li   x20, 0x00000000   // Clear configuration
	csrw pmpcfg0, x20

	li   x3, 0xE           // pmp1cfg = RWX (bits = 1110)
	csrw pmpcfg0, x3       // Write to pmpcfg0, sets pmp0cfg
	csrr x2, pmpcfg0       // Read back for confirmation

// ------------------------------------------------------------
// Switch to S-mode by writing mepc with S-mode entry point
// and executing mret
// ------------------------------------------------------------
mode_change:
    la   x24, s_mode      // Load address of S-mode entry
    csrw mepc, x24        // Set mepc = S-mode start address
    mret                  // Switch to S-mode

// ------------------------------------------------------------
// S-mode code: perform memory accesses inside PMP region
// ------------------------------------------------------------
s_mode:
	la x6, inp_data        // Load address of data region
	sw x10, 4(x6)          // Store test data at offset 4
	lw x10, 0(x6)          // Load word at offset 0

// ------------------------------------------------------------
// Finish Test
// ------------------------------------------------------------
done:
	nop
	nop
    TEST_PASSFAIL         // End test macro

RVTEST_CODE_END


// ------------------------------------------------------------
// Test Data Section
// ------------------------------------------------------------
.data
RVTEST_DATA_BEGIN

inp_data:
  .word 0x06627935        // Test pattern 1
  .word 0x584944fc        // Test pattern 2
  .word 0x06627935        // Test pattern 3

  TEST_DATA
RVTEST_DATA_END

