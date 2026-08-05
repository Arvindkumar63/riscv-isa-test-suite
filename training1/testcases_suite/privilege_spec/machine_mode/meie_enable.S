///==========================================================
/// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
///
/// Date:          19-11-2025
/// Owner:         Arvind Kumar Kori
/// Testcase Name: meie_disable 
/// Description:
/// This test verifies that the machine external  Interrupt is triggered only when all required conditions are satisfied:
/// mstatus[1] = 1 (MIE)
/// mideleg[11] = 0
/// mie[11] = 1 
/// mip[11] = 1 
/// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
	li x3, 0x8
	csrr x2, mstatus	//read the default value of mstatus reg, x2= 0x0000000a00000080
	csrw mstatus, x3 
	csrr x4, mstatus	//after enabling the mie bit in m status, x4= 0x0000000a00000008

level1:
	li x7, 0x800
	li x3, 0 
	csrr x5, mip		// default value x5 = 0x0
	csrr x9, mie		// default value x9 = 0x0
	csrr x2, mideleg	// default value x2 = 0x0
//	csrw mideleg, x7	// By default mideleg[5] = 0 that's why i am getting interrupt
	csrw mie, x7		// mie is set
	csrw mip, x3		// mip bit not set so interrupt will not generate

//	csrw mip, x7		// mip bit set so interrupt will generate

level2: 
	addi x6, x7, 8		// due to absence of software interrupt i am able to observe x6 = 16 value

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

#	Setup trap handler in M-mode 
	la   x2, mtvec_handler
        csrw mtvec, x2
    /* ------------------------------------------------------------- */
    /* PART A: Detect U-mode presence */
    /* Try to enter U-mode by setting mstatus.MPP = 0b00 (U) */
    csrr t0, mstatus
    li   t1, ~(3 << 11)
    and  t0, t0, t1          /* clear MPP bits */
    csrw mstatus, t0

    /* Set mepc to label u_mode_entry */
    la   t0, u_mode_entry
    csrw mepc, t0
    mret                      /* enter U-mode (if implemented) */

    /* If hart traps here, mtvec_handler will detect and note U-mode absent */

u_mode_entry:
    /* We are in U-mode if this executes */
    li   t0, 1                /* Flag: U-mode exists */
    sw   t0, 0(u_mode_flag)

    /* ------------------------------------------------------------- */
    /* PART B: Check mcounteren exists and WARL-zero behavior */
    /* Try writing 0xFFFFFFFF to mcounteren */
    li   t1, 0xFFFFFFFF
    csrw mcounteren, t1       /* Should not trap in M-mode */

    /* Read back mcounteren, may legally return 0 */
    csrr t2, mcounteren
    sw   t2, 0(mcounteren_val)

    /* ------------------------------------------------------------- */
    /* PART C: Attempt to read counters in U-mode (should trap if WARL-zero) */
    csrr t3, cycle             /* Expected: trap if mcounteren=0 */
    csrr t4, instret
    csrr t5, hpmcounter3
    csrr t6, time

    /* If we reach here without trap, fail */
    j    test_fail

/* --------------------------- M-mode trap handler -------------------------- */
mtvec_handler:
    csrr t0, mcause
    li   t1, 2                /* illegal-instruction code */
    beq  t0, t1, trap_illegal_instruction
    /* other traps: fail */
    j    test_fail

trap_illegal_instruction:
    /* Skip trapped instruction */
    csrr t2, mepc
    addi t2, t2, 4
    csrw mepc, t2

    /* Return to M-mode main test routine or U-mode retry if needed */
    /* Here we simply continue to signal pass */
    j    test_pass

/* --------------------------- End labels -------------------------- */
test_pass:
    li   a0, 1                /* PASS flag for testbench */
    j    end

test_fail:
    li   a0, 0                /* FAIL flag for testbench */
    j    end

end:
    wfi

/* --------------------------- Data section -------------------------- */
    .data
u_mode_flag:
    .word 0
mcounteren_val:
    .word 0

