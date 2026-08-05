#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN


start:
    la      x1, trap_handler
    csrw    mtvec, x1

//--------------------------------------------------
// Setup Sv39 page table
//--------------------------------------------------
// satp format for RV64 Sv39:
// [63:60] MODE = 8
// [59:44] ASID
// [43:0]  root page table PPN
//--------------------------------------------------

    la      x1, root_page_table
    srli    x1, x1, 12              

    li      x2, 8
    slli    x2, x2, 60              // MODE = Sv39

    or      x1, x1, x2
    csrw    satp, x1


//--------------------------------------------------
// Switch from M-mode to S-mode
//--------------------------------------------------
// mstatus.MPP = 01 
//--------------------------------------------------

    la      x1, s_mode_start
    csrw    mepc, x1

    csrr    x2, mstatus

    // Clear MPP bits [12:11]
    li      t2, ~(3 << 11)
    and     x2, x2, t2

    // Set MPP = Supervisor mode = 01
    li      t2, (1 << 11)
    or      x2, x2, t2

    csrw    mstatus, x2
    mret

//--------------------------------------------------
// Supervisor mode code
//--------------------------------------------------
s_mode_start:

    la      x5, inp_data

    lw      x15, 0(x5)
    li      x16, 0x06627935
    sw 		x15, 4(x5)

    

 jal x0, pass
//--------------------------------------------------
// Trap handler
//--------------------------------------------------

trap_handler:
    csrr    x1, mcause
    csrr    x2, mepc
    // If any unexpected trap comes, fail
    addi x2,x2,0x4
	csrw mepc,x2
	mret
    TEST_PASSFAIL

RVTEST_CODE_END


.section .data
.align 12

root_page_table:
    .dword 0x0
    .dword 0x0
    .dword ((0x80000000 >> 12) << 10) | 0xCB
    .zero 4096 - 24


RVTEST_DATA_BEGIN
    TEST_DATA

.align 3

inp_data:
    .word 0x06627935
    .word 0x584944fc
    .word 0x06627935
    .word 0x06627912
    .word 0x584944fc
    .word 0x584944fc
    .word 0x558f5366
    .word 0x558f5366
    .word 0x29df2fb1
    .word 0x29df2fb1
    .word 0x40053e92
    .word 0x40053e92

RVTEST_DATA_END
