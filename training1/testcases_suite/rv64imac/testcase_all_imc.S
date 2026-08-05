#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 3
start:

////////////////////////////////////////////////////////////
// INTEGER INSTRUCTIONS
////////////////////////////////////////////////////////////

add:
    li x1, 10
    li x2, 20
    add x3, x1, x2         # x3 = 30

addi:
    li x1, 5
    addi x2, x1, 7         # x2 = 12

sub:
    li x1, 30
    li x2, 10
    sub x3, x1, x2

sll:
    li x1, 1
    sll x2, x1, 3          # x2 = 8

slli:
    li x1, 2
    slli x2, x1, 4

srl:
    li x1, 0x20
    srl x2, x1, 2

srli:
    li x1, 0x100
    srli x2, x1, 4

sra:
    li x1, -32
    sra x2, x1, 2

srai:
    li x1, -64
    srai x2, x1, 3

slt:
    li x1, 5
    li x2, 10
    slt x3, x1, x2

sltu:
    li x1, 0xFFFFFFFFFFFFFFFF
    li x2, 1
    sltu x3, x1, x2

slti:
    li x1, 5
    slti x2, x1, 8

sltiu:
    li x1, 0xFFFFFFFFFFFFFFFF
    sltiu x2, x1, 5

and:
    li x1, 0xF0
    li x2, 0x0F
    and x3, x1, x2

andi:
    li x1, 0xAA
    andi x2, x1, 0x0F

or:
    li x1, 0x55
    li x2, 0x0F
    or x3, x1, x2

ori:
    li x1, 0x10
    ori x2, x1, 0x0F

xor:
    li x1, 0xAA
    li x2, 0xFF
    xor x3, x1, x2

xori:
    li x1, 0x0F
    xori x2, x1, 0xF0

lb:
    la x1, inp_data
    lb x2, 0(x1)

lh:
    la x1, inp_data
    lh x2, 2(x1)

lw:
    la x1, inp_data
    lw x2, 4(x1)

lbu:
    la x1, inp_data
    lbu x2, 1(x1)

lhu:
    la x1, inp_data
    lhu x2, 0(x1)

sb:
    la x1, store_loc
    li x2, 0x12
    sb x2, 0(x1)

sh:
    la x1, store_loc
    li x2, 0x1234
    sh x2, 0(x1)

sw:
    la x1, store_loc
    li x2, 0x12345678
    sw x2, 0(x1)

jal:
    jal x1, jal_label
    nop
jal_label:

jalr:
    la x1, jalr_label
    jalr x2, 0(x1)
    nop
jalr_label:

beq:
    li x1, 5
    li x2, 5
    beq x1, x2, beq_taken
    nop
beq_taken:

bne:
    li x1, 5
    li x2, 6
    bne x1, x2, bne_taken
    nop
bne_taken:

blt:
    li x1, 2
    li x2, 5
    blt x1, x2, blt_taken
    nop
blt_taken:

bge:
    li x1, 5
    li x2, 1
    bge x1, x2, bge_taken
    nop
bge_taken:

bltu:
    li x1, 1
    li x2, 5
    bltu x1, x2, bltu_taken
    nop
bltu_taken:

bgeu:
    li x1, 10
    li x2, 5
    bgeu x1, x2, bgeu_taken
    nop
bgeu_taken:

lui:
    lui x1, 0x12345

auipc:
    auipc x1, 0x10

//fence:
//    fence
//
//fence_i:
//    fence.i
//
//ecall:
//    ecall
//
//ebreak:
//    ebreak


////////////////////////////////////////////////////////////
// M-EXT (MULTIPLICATION)
////////////////////////////////////////////////////////////

mul:
    li x1, 5
    li x2, 6
    mul x3, x1, x2

mulh:
    li x1, 0x10000
    li x2, 0x20000
    mulh x3, x1, x2

mulhsu:
    li x1, -5
    li x2, 10
    mulhsu x3, x1, x2

mulhu:
    li x1, 0xFFFFFFFF
    li x2, 0x10
    mulhu x3, x1, x2

mv:
    li x1, 123
    mv x2, x1


////////////////////////////////////////////////////////////
// COMPRESSED INSTRUCTIONS
////////////////////////////////////////////////////////////

c_add:
    li x1, 5
    li x2, 7
    c.add x2, x1

c_addi:
    li x1, 8
    c.addi x1, 3

//c_addiw:
//    li x1, 5
//    c.addiw x1, 2
//
//c_and:
//    li x1, 0xF0
//    li x2, 0x0F
//    c.and x1, x2
//
//c_addw:
//    li x1, 10
//    li x2, 20
//    c.addw x1, x2
//
//c_andi:
//    li x1, 0xAA
//    c.andi x1, 0x0F
//
//c_beqz:
//    li x1, 0
//    c.beqz x1, cbeqz_taken
//    nop
//cbeqz_taken:
//
//c_bnez:
//    li x1, 1
//    c.bnez x1, cbnez_taken
//    nop
//cbnez_taken:
//
//c_ebreak:
//    c.ebreak
//
//c_j:
//    c.j cj_label
//cj_label:
//
//c_jal:
//    c.jal cjal_label
//cjal_label:
//
//c_jalr:
//    c.jalr x1
//
//c_jr:
//    c.jr x1
//
//c_ld:
//    c.ld x3, 0(x1)
//
//c_li:
//    c.li x1, 10
//
//c_lui:
//    c.lui x2, 0x12
//
//c_lw:
//    c.lw x2, 0(x1)
//
//c_mv:
//    c.mv x2, x1
//
//c_or:
//    c.or x2, x1
//
//c_sd:
//    c.sd x2, 0(x1)
//
//c_slli:
//    c.slli x1, 2
//
//c_srai:
//    c.srai x1, 3
//
//c_srli:
//    c.srli x1, 2
//
//c_sub:
//    c.sub x1, x2
//
//c_subw:
//    c.subw x1, x2
//
//c_sw:
//    c.sw x3, 0(x1)
//
//    c.swsp x3, 8(sp)
//
//c_xor:
//    c.xor x1, x2
//

////////////////////////////////////////////////////////////
// TEST END
////////////////////////////////////////////////////////////

TEST_PASSFAIL
RVTEST_CODE_END


.data
RVTEST_DATA_BEGIN

inp_data:
  .word 0x06627935
  .word 0x584944FC
  .word 0x11223344

store_loc:
  .word 0x00000000

TEST_DATA

RVTEST_DATA_END

