#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN
li gp, 5

start:

li x6,4 # x6=t1 temporary registers //c.li = 2 byte instr. without any pseudoinstr. bcz it is itself a pseudoinstr  # for small unsigned value

li x7,-3  //c.li = 2 byte instr. without any pseudoinstr. bcz it is itself a pseudoinstr  # for small signed value

li x8,0xabcd1234 # x7=t2 temporary registers // the pseudoinstr of li are 
                           //lui => x8=0xac00  and
								  //addiw => x8= 0xabcd1 
								  ///c.slli => x8= 0xabcd1000
								  //addi => x8 = 0xabcd1234 (final imm)
								  # for large unsigned value



li x9,0xfffffffafbcd1234 // pseudoinstr same as of li x8, 0xabcd1234

test1:
la x6,inp_data # x6=t1 temporary registers // the pseudoinstr of la are 
                           //auipc => x6=0x8000212c
								  //addi => x8= 0x80002000	 (final addr.)
								  # for large unsigned value

TEST_PASSFAIL
RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA

inp_data:
 .word 0x1234abcd

RVTEST_DATA_END


