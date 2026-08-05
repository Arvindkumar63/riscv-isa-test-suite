// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        24-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  TC_MP_SIMPLE_LOCK_X3_X7
// Description:  Simple RV64 multiprocessor-style test using only
//               x3 and x7 registers to write to shared memory
//               via atomic locking.
//
// ===========================================================



#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

    // Simulating Core 0
    la x3, lock
core0_try:
    li x7, 1
    amoswap.d.aq x7, x7, (x3)   // lock: x7 = old, x7(new) = 1
    bnez x7, core0_try          // if locked, retry

    la x3, shared
    li x7, 0xAAAA
    sd x7, 0(x3)                // Write shared = 0xAAAA

    la x3, lock
    li x7, 0
    sd x7, 0(x3)                // Release lock

    la x3, done0
    li x7, 1
    sd x7, 0(x3)                // Mark core 0 done

    // Simulating Core 1
    la x3, lock
core1_try:
    li x7, 1
    amoswap.d.aq x7, x7, (x3)   // Try to acquire lock
    bnez x7, core1_try

    la x3, shared
    li x7, 0xBBBB
    sd x7, 0(x3)                // Write shared = 0xBBBB

    la x3, lock
    li x7, 0
    sd x7, 0(x3)                // Release lock

    la x3, done1
    li x7, 1
    sd x7, 0(x3)                // Mark core 1 done

    // Final Validation
    la x3, shared
    ld x7, 0(x3)
    li x3, 0xAAAA
    beq x7, x3, pass

    li x3, 0xBBBB
    beq x7, x3, pass

fail:
    RVTEST_FAIL

pass:
    RVTEST_PASS

RVTEST_CODE_END

RVTEST_DATA_BEGIN
    .align 3
lock:   .dword 0
shared: .dword 0
done0:  .dword 0
done1:  .dword 0
RVTEST_DATA_END

