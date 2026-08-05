/*=========================================================== 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date        : 27-11-2025
Owner       : Sudeepta

Testcase name:mode_change_pmp_tor

Description :
  • PMP controls permissions: set X for instruction fetches (i-cache/execution),
    R for loads (data-memory reads), and W for stores (data-memory writes).
  • This test configures a PMP entry and then switches to S-mode to exercise
    load/store behavior relative to the configured PMP region.
  • Note (user text): If using TOR and pmpaddr0 = 0x80002000 then the region
    semantics are that addresses below the top-of-range are matched appropriately.
=============================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3                    # initialize gp required by the test harness

start:
  nop                         # small entry nop

  # ---------------------------
  # make an mstatus modification you had in original code
  # (keeps any bits you intended to set; original used 0x800)
  # ---------------------------
  csrr x22, mstatus           # read current mstatus
  li   x23, 0x800             # immediate to OR into mstatus (keep as original)
  or   x22, x22, x23          # set selected bits
  csrw mstatus, x22           # write back mstatus

pmp_addr:
  csrr x4,  pmpaddr0          # read pmpaddr0 0x003fffffffffffff
  
  csrr x12, pmpaddr1          # read pmpaddr1 (optional readback)

  li   x5, 0x80003000         # raw physical address to place into pmpaddr0 (top/limit)
  srli x21, x5, 2             # PMP expects addr >> 2 (logical shift)
  csrw pmpaddr0, x21          # program pmpaddr0

pmp_cfg:
  csrr x2, pmpcfg0            # read current pmpcfg0
  li   x20, 0x00000000
  csrw pmpcfg0, x20           # clear pmpcfg0 while programming (original)
  li   x3, 0xD                # original code writes 0xD to pmpcfg0
  csrw pmpcfg0, x3            # write pmpcfg0
  csrr x2, pmpcfg0            # readback for verification

mode_change:
  la   x24, s_mode            # load address of s_mode label
  csrw mepc, x24              # set MEPC so mret goes to s_mode
  mret                        # return from M-mode to target MEPC (S-mode)

s_mode:
  la   x6, inp_data          # address of data section
  lw   x10, 0(x6)            # load from memory -> it will execute normally as load has permission
  sw   x10, 4(x6)            # store to memory  -> it will trap because no permission for write

done:
  nop
  nop
  TEST_PASSFAIL              

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
inp_data:
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  TEST_DATA
RVTEST_DATA_END

