#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li gp, 3

start:

# ---------------------------------------------
# Step 1: Load page table base address
# ---------------------------------------------

    la      x1, l1_page_table

# ---------------------------------------------
# Step 2: Configure SATP register
# MODE = 8 (Sv39)
# ---------------------------------------------

    srli    x2, x1, 12          # PPN
    li      x3, 8               # Sv39 mode
    slli    x3, x3, 60          # MODE field
    or      x2, x2, x3

    csrw    satp, x2            # Enable MMU

# ---------------------------------------------
# Step 3: Flush TLB
# ---------------------------------------------

    sfence.vma

# ---------------------------------------------
# Step 4: Virtual address access
# ---------------------------------------------

    la      x4, virtual_data
    li      x5, 0x12345678
    sw      x5, 0(x4)           # Store via VA
    lw      x6, 0(x4)           # Load via VA

# ---------------------------------------------
# Step 5: Check result
# ---------------------------------------------

    li      x7, 0x12345678

    bne     x6, x7, fail

pass:
    j       ch

fail:
    li      gp, 1

ch:

    TEST_PASSFAIL

RVTEST_CODE_END


# --------------------------------------------------
# Data Section
# --------------------------------------------------

.data

RVTEST_DATA_BEGIN

TEST_DATA

# ---------------------------------------------
# Level-1 Page Table
# ---------------------------------------------

.align 12

l1_page_table:

    .quad page_entry

# ---------------------------------------------
# Page Table Entry
# Flags:
# V=1 R=1 W=1 X=0
# ---------------------------------------------

page_entry:

    .quad (
        (physical_data >> 12) << 10 |
        0x7
    )

# ---------------------------------------------
# Virtual Address
# ---------------------------------------------

.align 12

virtual_data:

    .word 0

# ---------------------------------------------
# Physical Address
# ---------------------------------------------

.align 12

physical_data:

    .word 0

RVTEST_DATA_END
