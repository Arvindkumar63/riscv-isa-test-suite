/*=========================================================== 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date        : 27-11-2025
Owner       : Sudeepta
Testcase    : tc_napot_only_read_cnfg
 
Description :reset the configuration and provide access for 
             read and execute, and perform read, write and
             execute in napot.
=============================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3                        # Signature register

#-------------------------------------------------------------
# Install machine trap handler
#-------------------------------------------------------------
trap_handler:
	la   x31, m_trap_handler
	csrw mtvec, x31

#-------------------------------------------------------------
# Enable M-mode interrupts (set MIE bit)
#-------------------------------------------------------------
start:
	nop
	csrr x5, mstatus           # Read mstatus
	li   x6, 0x800             # MIE bit mask (bit 11)
	or   x5, x5, x6
	csrw mstatus, x5

RESET_CONFIGURATION:
    nop

# ---------- RESET CONFIGURATION ----------
address:
	csrr x7, pmpaddr0          # Read previous value
        
read_cfg:
	csrr x9, pmpcfg0           # Read existing pmpcfg0

	li   x10, 0x00000000       # Clear all configs
	csrw pmpcfg0, x10
	csrr x9, pmpcfg0           # Read pmpcfg0


#-------------------------------------------------------------
# PMP Address Configuration (NAPOT Encoded)
#-------------------------------------------------------------
CONFIGURATION:
    nop

# ---------- pmpaddr0 (NAPOT region 1) ----------
addr0:

	li   x8, 0x80002000        # Base address
	srli x8, x8, 2             # PMP stores bits [XLEN-1:2]

	li   x18, 0xF              # NAPOT mask for 32-byte region (4 lower bits = 1111)
	or   x18, x18, x8
	csrw pmpaddr0, x18         # Write NAPOT encoded address

# ---------- pmpaddr1 (NAPOT region 2) ----------
addr1:
	csrr x15, pmpaddr1         # Read previous value

	li   x16, 0x80000000       # Base address
	srli x16, x16, 2
	li   x17, 0x3FF            # NAPOT mask for 4 KB region (lowest 10 bits = 1s)
	or   x16, x16, x17
	csrw pmpaddr1, x16

#-------------------------------------------------------------
# PMP Configuration Registers
#-------------------------------------------------------------
# 0x1F1D provides RWX permissions + NAPOT addressing modes for both entries
	li   x11, 0x1F1D
	csrw pmpcfg0, x11

	csrr x9, pmpcfg0           # Read back for verification

#-------------------------------------------------------------
# Switch to S-mode (set mepc & use mret)
#-------------------------------------------------------------
mode_change:
    la   x12, s_mode
    csrw mepc, x12
    mret

# -------------------------------------------------------------
# ---------------------- S-mode Code -------------------------
# -------------------------------------------------------------
s_mode:
	la x13, inp_data           # Base address for loads/stores

# Normal Load
load:
	lw x14, 0(x13)
        nop
	nop
# Normal Store
store:
    sw x14, 4(x13)			   #trap because not permited for store 
	nop
	nop

    jal x0, done

#-------------------------------------------------------------
# -------------------- Trap Handler --------------------------
#-------------------------------------------------------------
m_trap_handler:
	csrr x25, mepc             # Read current EPC
	addi x25, x25, 4           # Skip the faulting instruction
	csrw mepc, x25
	mret

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
  .word 0x584944fc
  .word 0x06627935
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  .word 0x584944fc

  TEST_DATA
RVTEST_DATA_END


