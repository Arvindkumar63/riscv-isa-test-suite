/*==========================================================
 Copyright  2025 Scaledge India Pvt Ltd

 Testcase Name : ssie_enable
 Description   :
   • enter S-mode
   • enable SSIE & set SIP.SSIP
   • supervisor software interrupt handled
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp,     3                   


start:
#   S-mode trap handler (set stvec from M-mode)

    la      x5,     trap_handler       // handler addr
    csrw    stvec,  x5                 // set stvec for S-mode
    nop
    nop

# prepare mstatus: set MPP=01 (S-mode)mstatus[12:11] = 01,mstatus[1]=1 and mstatus[3]=1 
    csrr    x2,     mstatus				// Default value of mstatus register
    li      x3,     0x80A              // 
    csrrs   mstatus, x2
    la      x6,     s_mode
    csrw    mepc,   x6                  // next PC for mret
    mret                                // enter S-mode

# ---------------- S-MODE & tranp occurs in this mode ----------------
s_mode:
    li      x8,     0x2                 // SSTATUS.SIE mask
   csrrs   x0,     sstatus, x8        // enable SIE

# enable SSIE in SIE
    li      x7,     0x2                 // SSIE mask
    csrrs   x0,     sie,     x7
    csrr    x9,     sie                 // read sie
# self-check: mie.SSIE bit is set
    li      x1,     0x2
    bne     x1,     x9,     fail        // SSIE check 


# set SIP.SSIP to pend supervisor SW interrupt
    li      x10,    0x2                 // SSIP mask
    csrrs   x0,     sip,     x10
    csrr    x11,    sip                 // read sip


    jal     x0,     exit                // avoid hang

# ---------------- S-mode trap handler (runs in S-mode) ----------------
.align 4
trap_handler:
    csrr    x12,    scause              // read scause
#	self  checking logic for scause


    csrr    x13,    sepc                // read sepc
    addi    x13,    x13,    4
    csrw    sepc,   x13                 // skip trapped instr

# clear SIP.SSIP before return
    li      x14,    0x2
    csrc    sip,    x14                 // clear SSIP

    sret                                // return to S-mode

# ---------------------------------------------------------------------

exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN    
    TEST_DATA
RVTEST_DATA_END
                                                                                           
