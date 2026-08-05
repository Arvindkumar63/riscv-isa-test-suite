/*===========================================================
  Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           22-12-2025
  Owner:          Sudeepta

  Testcase Name: tc_load_add_miss 

  Description:Read defult pmp configuration for for your setup and check the configuration. 
             check according to which range type it is configured
    
=============================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3                  

# -----------------------------------------------------------
#               MACHINE MODE ENTRY POINT
# -----------------------------------------------------------
start:

# Install Machine-mode trap handler
Install_trap_handler:
    la      x5, my_Trap_handler
    csrw    mtvec, x5              # Set mtvec to trap handler

pmp_addr:
    nop

# ---------- pmpaddr0 (NAPOT region 1) ----------
addr0:
	csrr x7, pmpaddr0          # Read previous value

	li   x8, 0x80002000        # Base address
	srli x8, x8, 2             # PMP stores bits [XLEN-1:2]

	li   x18, 0x 8             # NAPOT mask for 32-byte region (4 lower bits = 1111)
	or   x18, x18, x8
	csrw pmpaddr0, x18         # Write NAPOT encoded address

# ---------- pmpaddr1 (NAPOT region 2) ----------
pmp_cfg:
	csrr x6, pmpcfg0           # Read existing pmpcfg0

	li   x7, 0x00000000       # Clear all configs
	csrw pmpcfg0, x8
            
mode_change:
    li   x13, 0x800
	csrw mstatus,x13
    la   x12, s_mode
    csrw mepc, x12
    mret

# ---------------------- S-mode Code -------------------------
s_mode:
	la x6,inp_data
	lw x10,0(x6)
	sw x10,4(x6)
	lw x10,0(x6)
TEST_PASSFAIL

RVTEST_CODE_END


.data
RVTEST_DATA_BEGIN

inp_data:
    .word   0x06627935
    .word   0x584944fc
    .word   0x06627935
    .word   0x06627935
    .word   0x584944fc
    .word   0x06627935

    TEST_DATA

RVTEST_DATA_END



