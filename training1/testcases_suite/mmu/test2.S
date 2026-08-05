#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

 

start:
    la      x1, trap_handler
    csrw    mtvec, x1

//--------------------------------------------------
// Setup Sv39 page table
//--------------------------------------------------
// satp format for RV64 Sv39:
// [63:60] MODE = 8
// [59:44] ASID
// [43:0]  root page table PPN
//--------------------------------------------------

    la      x1, root_page_table
    srli    x1, x1, 12             

    li      x2, 8
    slli    x2, x2, 60              

    or      x1, x1, x2
    csrw    satp, x1


//--------------------------------------------------
// Switch from M-mode to S-mode
//--------------------------------------------------
// mstatus.MPP = 01 
//--------------------------------------------------

    la      x1, s_mode_start
    csrw    mepc, x1

    csrr    x2, mstatus

    // Clear MPP bits [12:11]
    li      t2, ~(3 << 11)
    and     x2, x2, t2

    // Set MPP = Supervisor mode = 01
    li      t2, (1 << 11)
    or      x2, x2, t2

    csrw    mstatus, x2
    mret

//--------------------------------------------------
// Supervisor mode code
//--------------------------------------------------
s_mode_start:



    la      x5, inp_data 
    lw      x15, 0(x5)

jal x0, pass

 

//--------------------------------------------------
// Trap handler
//--------------------------------------------------

trap_handler:
    csrr    x1, mcause
    csrr    x2, mepc

    // If any unexpected trap comes, fail
    li      gp, 3
    TEST_PASSFAIL

RVTEST_CODE_END


.section .data
/*.align 12

root_page_table:// address=0x80002000
    .dword 0x0
    .dword 0x0
    .dword ((0x80000000 >> 12) << 10) | 0xCF
    .zero 4096 - 24
*/
//--------------------------------------------------
// ROOT PAGE TABLE (Level-2)
// Physical address = 0x80002000
// VPN[2] = 2 for VA 0x80000000
//--------------------------------------------------

 

 

root_page_table:

 

    .dword 0x0
    .dword 0x0

 

    // index 2 -> level1 table addr = 0x80003000
    .dword ((0x80003000 >> 12) << 10) | 0x1

 

    .zero 4096 - 24

 

//--------------------------------------------------
// LEVEL-1 PAGE TABLE
// Physical address = 0x80003000
// VPN[1] = 0
//--------------------------------------------------

 

 

.align 12
.org 0x1000 // base address + org value

 

l1_page_table:

 

    // index 0 -> level0 table addr = 0x80004000
    .dword ((0x80004000 >> 12) << 10) | 0x1

 

    .zero 4096 - 8

 

//--------------------------------------------------
// LEVEL-0 PAGE TABLE
// Physical address = 0x80004000
// LEAF PTEs
//--------------------------------------------------

 

.align 12
.org 0x2000

 

l0_page_table:

 

//--------------------------------------------------
// VPN[0] = 0 for inst
// VA 0x80000000 -> PA 0x80000000
//--------------------------------------------------

 

    .dword ((0x80000000 >> 12) << 10) | 0xCF

 

//--------------------------------------------------
// VPN[0] = 1
//--------------------------------------------------

 

    .dword 0x0

 

//--------------------------------------------------
// calculate VPN[0] for load address and write pte for it
// ex: for load address 0x80002040 , vpn[0] is 2
//--------------------------------------------------

 

    .dword ((0x80002000 >> 12) << 10) | 0xCF

 

    .zero 4096 - 24

 


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
