/*===========================================================
  Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           18-12-2025
  Owner:          Sudeepta

  Testcase Name:  tc_load_add_miss

  Description:
    This test verifies handling of Load Address Misaligned
    exceptions in Machine mode.

    The test intentionally performs multiple misaligned
    LW (load word) instructions using unaligned addresses
    (offsets 1, 2, 3, 5, 6, 7, 9, 10, 11).

    Each misaligned access must raise a
    "Load Address Misaligned" exception (mcause = 4).

    The Machine-mode trap handler:
      • Confirms mcause = 4
      • Reads mtval to get the faulting address
      • Adjusts the program counter (mepc) to resume execution
      • Allows execution to continue to the next instruction

    Successful completion indicates that all misaligned
    load traps are correctly detected and handled.
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
pmp_cfg:
	csrr x6, pmpcfg0           # Read existing pmpcfg0

	li   x7, 0x00000000       # Clear all configs
	csrw pmpcfg0, x8

	li   x9, 0x1E1E
	csrw pmpcfg0, x9
	csrr x10, pmpcfg0 
            
mode_change:
    li   x13, 0x800
	csrw mstatus,x13
    la   x12, s_mode
    csrw mepc, x12
    mret

# ---------------------- S-mode Code -------------------------
s_mode:
	la x13, inp_data           # Base address for loads/stores


load:
level1:
    la      x9, inp_data           # Base address of test data
trap1:
    lw      x12, 13(x9)             # Misaligned load (offset 1)

trap2:
    lw      x12, 1(x9)             # Misaligned load (offset 1)

trap3:
    lw      x12, 2(x9)             # Misaligned load (offset 2)

trap4:
    lw      x12, 3(x9)             # Misaligned load (offset 3)

trap5:
    lw      x12, 5(x9)             # Misaligned load (offset 5)

trap6:
    lw      x12, 6(x9)             # Misaligned load (offset 6)

trap7:
    lw      x12, 7(x9)             # Misaligned load (offset 7)

trap8:
    lw      x12, 9(x9)             # Misaligned load (offset 9)

trap9:
    lw      x12, 10(x9)            # Misaligned load (offset 10)

trap10:
    lw      x12, 11(x9)            # Misaligned load (offset 11)


	.align 4
my_Trap_handler:

    csrr    x12, mepc              # Read faulting PC
    csrr    x11, mcause            # Read exception cause
    csrr    x10, mtval             # Read faulting address

    li      x13, 0x4               # mcause = 4 (Load Addr Misaligned)
    li		x26, 0x5
    # Verify exception cause
    beq     x13, x11, load_add_mis
    beq	    x26, x11, load_access_fault

# Handle Load Address Misaligned exception
load_add_mis:
    # mtval contains faultinglting address
    # Calculate misalignment (address % 4)
    rem     x14, x10, x13

    add     x15, x14, x14
    sub     x9,  x9,  x14


    mret

load_access_fault:
 nop

	li   x9, 0x1F1F
	csrw pmpcfg0, x9
	csrr x10, pmpcfg0
addr0_1:
	csrr x7, pmpaddr0          # Read previous value

	li   x8, 0x80002000        # Base address
	srli x8, x8, 2             # PMP stores bits [XLEN-1:2]

	li   x18, 0xF              # NAPOT mask for 32-byte region (4 lower bits = 1111)
	or   x18, x18, x8
	csrw pmpaddr0, x18         # Write NAPOT encoded address
addr1_1:
	csrr x15, pmpaddr1         # Read previous value

	li   x16, 0x80000000       # Base address
	srli x16, x16, 2
	li   x17, 0x3FF            # NAPOT mask for 4 KB region (lowest 10 bits = 1s)
	or   x16, x16, x17
	csrw pmpaddr1, x16

    mret

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


