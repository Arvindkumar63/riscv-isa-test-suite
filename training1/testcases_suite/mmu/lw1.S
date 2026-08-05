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
//
// satp[63:60] = MODE
// satp[59:44] = ASID
// satp[43:0]  = root page table PPN
//
// MODE = 8 for Sv39
//--------------------------------------------------

    la      x1, root_page_table
    srli    x1, x1, 12              // root page table PPN

    li      x2, 8
    slli    x2, x2, 60              // MODE = Sv39

    or      x1, x1, x2              // satp = MODE | PPN
    csrw    satp, x1

    sfence.vma x0, x0

//--------------------------------------------------
// Switch from M-mode to S-mode
//--------------------------------------------------
// mstatus.MPP = 01 means Supervisor mode
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
load:
    la      x5, inp_data

    lw      x15, 0(x5)
    li      x16, 0x06627935
    bne     x15, x16, fail

    lw      x15, 4(x5)
    li      x16, 0x584944fc
    bne     x15, x16, fail

    lw      x15, 8(x5)
    li      x16, 0x06627935
    bne     x15, x16, fail

store:

    li      x17, 0x12345678
    sw      x17, 12(x5)

    lw      x18, 12(x5)
    bne     x18, x17, fail

jal x0, pass
trap_handler:
 	csrr    x10, mcause
    csrr    x11, mepc
    // If any unexpected trap comes, fail
    addi x11,x11,0x4
	csrw mepc,x11
	mret
    TEST_PASSFAIL

RVTEST_CODE_END

//--------------------------------------------------
// Data section
//--------------------------------------------------

.section .data
.align 12

//--------------------------------------------------
// Root Page Table for Sv39
//--------------------------------------------------
// This is 1GB superpage mapping.
//
// root_page_table[0]:
// VA 0x00000000 - 0x3fffffff
// PA 0x00000000 - 0x3fffffff
//
// root_page_table[1]:
// VA 0x40000000 - 0x7fffffff
// PA 0x40000000 - 0x7fffffff
//
// root_page_table[2]:
// VA 0x80000000 - 0xbfffffff
// PA 0x80000000 - 0xbfffffff
//
// PTE format:
// PTE = (PPN << 10) | flags
//
// flags = 0xCF
// V = 1
// R = 1
// W = 1
// X = 1
// U = 0
// G = 0
// A = 1
// D = 1
//--------------------------------------------------

root_page_table:

    //--------------------------------------------------
    // Entry 0
    // VA 0x00000000 -> PA 0x00000000
    //--------------------------------------------------
    .dword ((0x80000000 >> 12) << 10) | 0xC0

    //--------------------------------------------------
    // Entry 1
    // VA 0x40000000 -> PA 0x40000000
    //--------------------------------------------------
    .dword ((0x40000000 >> 12) << 10) | 0xCF

    //--------------------------------------------------
    // Entry 2
    // VA 0x80000000 -> PA 0x80000000
    //--------------------------------------------------
    .dword ((0x80000000 >> 12) << 10) | 0xCF

    //--------------------------------------------------
    // Remaining entries invalid
    //--------------------------------------------------
    .zero 4096 - 24

//--------------------------------------------------
// Test Data
//--------------------------------------------------

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
