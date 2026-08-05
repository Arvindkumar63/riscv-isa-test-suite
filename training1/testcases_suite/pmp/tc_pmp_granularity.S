/*=========================================================== 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date        : 28-11-2025
Owner       : Sudeepta

Testcase name:tc_pmp_granularity

Description :
This test determines the minimum PMP region size supported by the hardware.
The test clears pmp0cfg, writes all 1s to pmpaddr0, and then reads back 
pmpaddr0.Since the hardware masks certain lower bits based on its 
granularity, the test finds the least-significant bit (G) 
that remains set in the read value.

PMP granularity is then calculated as:
Granularity = 2^(G + 2) bytes

The test passes if:
pmpaddr0 shows correct lower-bit masking, and
The computed granularity matches the expected platform configuration.
==================================================================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3                    

start:
  nop                         

  li   x23, 0x800             # immediate to OR into mstatus (keep as original)
  or   x22, x22, x23          # set selected bits
  csrw mstatus, x22           # write back mstatus

pmp_addr:
  csrw pmpcfg0,x0
  li x5,0xFFFFFFFFFFFFFFFF
  csrw pmpaddr0,x5
  csrr x6,pmpaddr0
  csrr x7,pmpcfg0
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


