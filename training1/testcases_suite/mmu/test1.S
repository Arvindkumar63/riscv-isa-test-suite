#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

//--------------------------------------------------
// Start in Machine Mode
//--------------------------------------------------
start:
    //--------------------------------------------------
    // Set trap handler
    //--------------------------------------------------
    la      t0, trap_handler
    csrw    mtvec, t0

    //--------------------------------------------------
    // Build Sv39 3-level page table in M-mode
    //--------------------------------------------------
    // VA 0x80000000 -> PA 0x80000000
    //
    // Sv39 VA breakdown:
    // VA[38:30] = VPN[2]
    // VA[29:21] = VPN[1]
    // VA[20:12] = VPN[0]
    // VA[11:0]  = page offset
    //
    // For VA 0x80000000:
    // VPN[2] = 2
    // VPN[1] = 0
    // VPN[0] = 0
    //--------------------------------------------------

    //--------------------------------------------------
    // root_page_table[2] -> l1_page_table
    //--------------------------------------------------

    la      t0, l1_page_table       // address of level-1 page table
    srli    t0, t0, 12              // convert address to PPN
    slli    t0, t0, 10              // put PPN into PTE[53:10]
    ori     t0, t0, 0x1             // V = 1, non-leaf PTE

    la      t1, root_page_table
    sd      t0, 16(t1)              // index 2 * 8 = 16

    //--------------------------------------------------
    // l1_page_table[0] -> l0_page_table
    //--------------------------------------------------

    la      t0, l0_page_table
    srli    t0, t0, 12
    slli    t0, t0, 10
    ori     t0, t0, 0x1             // V = 1, non-leaf PTE

    la      t1, l1_page_table
    sd      t0, 0(t1)               // index 0

    //--------------------------------------------------
    // l0_page_table[0]
    // VA 0x80000000 -> PA 0x80000000
    //--------------------------------------------------

    li      t0, 0x80000000
    srli    t0, t0, 12
    slli    t0, t0, 10
    ori     t0, t0, 0xCF            // V,R,W,X,A,D = 1

    la      t1, l0_page_table
    sd      t0, 0(t1)               // index 0

    //--------------------------------------------------
    // l0_page_table[1]
    // VA 0x80001000 -> PA 0x80001000
    //--------------------------------------------------

    li      t0, 0x80001000
    srli    t0, t0, 12
    slli    t0, t0, 10
    ori     t0, t0, 0xCF

    la      t1, l0_page_table
    sd      t0, 8(t1)               // index 1 * 8

    //--------------------------------------------------
    // l0_page_table[2]
    // VA 0x80002000 -> PA 0x80002000
    //--------------------------------------------------

    li      t0, 0x80002000
    srli    t0, t0, 12
    slli    t0, t0, 10
    ori     t0, t0, 0xCF

    la      t1, l0_page_table
    sd      t0, 16(t1)              // index 2 * 8

    //--------------------------------------------------
    // l0_page_table[3]
    // VA 0x80003000 -> PA 0x80003000
    //--------------------------------------------------

    li      t0, 0x80003000
    srli    t0, t0, 12
    slli    t0, t0, 10
    ori     t0, t0, 0xCF

    la      t1, l0_page_table
    sd      t0, 24(t1)              // index 3 * 8

    //--------------------------------------------------
    // l0_page_table[4]
    // VA 0x80004000 -> PA 0x80004000
    //--------------------------------------------------

    li      t0, 0x80004000
    srli    t0, t0, 12
    slli    t0, t0, 10
    ori     t0, t0, 0xCF

    la      t1, l0_page_table
    sd      t0, 32(t1)              // index 4 * 8

    //--------------------------------------------------
    // Enable Sv39 MMU using satp
    //--------------------------------------------------
    // satp[63:60] = MODE = 8 for Sv39
    // satp[43:0]  = root page table PPN
    //--------------------------------------------------

    la      t0, root_page_table
    srli    t0, t0, 12              // root page table PPN

    li      t1, 8
    slli    t1, t1, 60              // MODE = Sv39

    or      t0, t0, t1
    csrw    satp, t0

    sfence.vma x0, x0

    //--------------------------------------------------
    // Switch from M-mode to S-mode
    //--------------------------------------------------
    // mstatus.MPP = 01 means S-mode
    //--------------------------------------------------

    la      t0, s_mode_start
    csrw    mepc, t0

    csrr    t1, mstatus

    // Clear MPP bits [12:11]
    li      t2, ~(3 << 11)
    and     t1, t1, t2

    // Set MPP = 01, Supervisor mode
    li      t2, (1 << 11)
    or      t1, t1, t2

    csrw    mstatus, t1

    mret

//--------------------------------------------------
// Supervisor mode code
//--------------------------------------------------
s_mode_start:

    sfence.vma x0, x0

    //--------------------------------------------------
    // Load from virtual address of inp_data
    //--------------------------------------------------

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

    //--------------------------------------------------
    // Store test
    //--------------------------------------------------
    li      x17, 0x12345678
    sw      x17, 12(x5)

    lw      x18, 12(x5)
    bne     x18, x17, fail

    //--------------------------------------------------
    // If load/store through MMU works, pass
    //--------------------------------------------------



//--------------------------------------------------
// Trap handler
//--------------------------------------------------
trap_handler:
    csrr    t0, mcause
    csrr    t1, mepc
    csrr    t2, mtval

    // Unexpected trap means fail
    li      gp, 3
    TEST_PASSFAIL

RVTEST_CODE_END

//--------------------------------------------------
// Page table memory
//--------------------------------------------------

.section .data

//--------------------------------------------------
// Root page table: Level-2
//--------------------------------------------------
// Must be 4KB aligned
//--------------------------------------------------

.align 12
root_page_table:
    .zero 4096

//--------------------------------------------------
// Level-1 page table
//--------------------------------------------------

.align 12
l1_page_table:
    .zero 4096

//--------------------------------------------------
// Level-0 page table
//--------------------------------------------------

.align 12
l0_page_table:
    .zero 4096

//--------------------------------------------------
// Test data
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
