#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 3                       # Signature register

#-------------------------------------------------------------
# Install machine trap handler
#-------------------------------------------------------------

trap_handler:
	la   x31, m_trap_handler
	csrw mtvec, x31


start:
	nop
	csrr x5, mstatus           # Read mstatus
	li   x6, 0x800             # MIE bit mask (bit 11)
	or   x5, x5, x6
	csrw mstatus, x5
addr0:

	li   x8, 0x80002000        # Base address
	srli x8, x8, 2             # PMP stores bits [XLEN-1:2]

	li   x9, 0xF              # NAPOT mask for 32-byte region (4 lower bits = 1111)
	or   x9, x9, x8
	csrw pmpaddr0, x9
addr1:
	csrr x15, pmpaddr1         # Read previous value

	li   x16, 0x80000000       # Base address
	srli x16, x16, 2
	li   x17, 0x3FF            # NAPOT mask for 4 KB region (lowest 10 bits = 1s)
	or   x16, x16, x17
	csrw pmpaddr1, x16
cfg:
	li   x11, 0x1F1E
	csrw pmpcfg0, x11

	csrr x9, pmpcfg0 

mode_change:
    la   x12, s_mode
    csrw mepc, x12
    mret

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
