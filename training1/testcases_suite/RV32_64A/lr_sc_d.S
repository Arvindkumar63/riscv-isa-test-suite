#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 3

# Test1: Perform lr.d and sc.d successfully on aligned memory
test1:
    li x1, 0
    la x2, inp_data
    lr.d x3, (x2)
    addi x4, x3, 1
    sc.d x5, x4, (x2) # if x5==0 then succes
    ld x6, 0(x2)

# Test2: lr.d + sc.d with add operation on large 64-bit value
test2:
    la x2, double
    lr.d x7, (x2)
    li x8, 0x1111111111111111
    add x9, x7, x8
    sc.d x10, x9, (x2)
    ld x11, 0(x2)



# Test3: sc.d fails if no lr.d was executed before
test3:
    la x2, double2
    li x13, 0xAAAAAAAAAAAAAAAA
    sc.d x14, x13, (x2)   # Should fail: no lr.d before
	 ld x12, 0(x2)  # x12 
    lr.d x15, (x2)        # Just load current value
	 

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA

inp_data:
    .dword 5

double:
    .dword 0x123456789ABCDEF0

	 double1:
    .dword 0x323456789ABCDEF0

double2:
    .dword 0x423456789ABCDEF0


RVTEST_DATA_END




























//# Test3: sc.d fails if reservation broken after lr.d
//test3:
//    la x2, double1
//    lr.d x12, (x2)
//    li x13, 0x5555555555555555
//    sd x13, 0(x2)       # Break reservation
//
//	  li x16, 0xabc555555555555a
//
//    sc.d x14, x16, (x2) # Should fail
//    ld x15, 0(x2)
