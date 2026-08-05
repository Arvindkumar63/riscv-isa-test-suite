########################################################################
//    Description: 
//
//    virtual to physical address translating (instruction):
//   		   #satp = 0x8000000000070002
//   		   #L2 pte_addr= 0x70002000 pte = 0x000000001c000401 
//   		   #L1 pte_addr= 0x70001000 pte = 0x000000001c000001 
//   		   #L0 pte_addr= 0x70000000 pte = 0x00000000000000cf 
//                 #VA = 0x0 
//                 #PA = 0x0 
//
//   virtual to physical address translating (Data):
//   		   #satp = 0x8000000000070002
//   		   #L2 pte_addr= 0x70002000 pte = 0x000000001c000401 
//   		   #L1 pte_addr= 0x70001100 pte = 0x000000001c000001 
//   		   #L0 pte_addr= 0x700000d0 pte = 0x600000001c0800c9    
//                 #VA = 0x401add8 
//                 #PA = 0x70200dd8
########################################################################

.align 4
 
handler_vs:
        li      a5,     0xd
        csrr    a7,     sepc
        addi    a7,     a7,     4
        csrw    sepc,   a7
 
	csrr    a6,     scause
	bne     a5,     a6,     _fail 
        sret
 
.align 4
 
handler_m:
	csrr x31,mepc
	addi x31,x31,4
	csrw mepc,x31
	csrr x30,mcause
	csrr x29,mtval
	mret
.align 4
code_begin:
 
        li      x12,    0x80                // Setting Misa 7th bit so that Hypervisor mode could be enabled
        csrw    misa,   x12
 
        li      x17,    0x2000              // Setting the medeleg LPF instruction delegation bit
        csrw    medeleg, x17
        csrr    x18,    medeleg
 
		li      x17,    0x2000              // Setting the hedeleg LPF instruction delegation bit
        csrw    hedeleg, x17
        csrr    x18,    hedeleg
 
        la      x22,    vs_mode
        csrw    mepc,   x22
 
	la      x23,    vs_mode
        csrw    sepc,   x23
 
	la      x11,     handler_vs
        csrw    stvec,  x11
 
	la      x11,     handler_m
        csrw    mtvec,  x11
        la      x7,     handler_vs
        csrw    vstvec,  x7
 
 
 
#define my_pc 0x0
	li x11, 0xF
	csrw pmpcfg0, x11
	li x12, 0xEFFFFFFFFF
	csrw pmpaddr0, x12
 
 
################################################
 
#define virtual_addr 0x0401ADD8
################################################
 
	li      x6,     0x8000040800        // Setting the MPP [12:11] bits as (01) for Hypervisor mode, MPV[39] = 1 for M to VS mode, SUM[18] = 1 for PTE
        csrw    mstatus, x6
 
        li x16, 0x0
        csrw 0x304, x16 # MIE
        li x16, 0x0
        csrw 0x104, x16 # SIE
	csrr t1, mstatus
 
mode_swf:
	 li a2, 0x8000000000000000
	 li t1, 0x70002000	 
	 srl t1,t1,12
	 or t1,t1,a2
	 csrw vsatp, t1  	 	      
	 mret
 
.align 4
 
vs_mode:
    li a0, 0
    li a0, virtual_addr
    li a1, 0xdeadbeef
    lw a1,(a0) 
    nop
    .rept 5
    nop
    .endr
 
 
 //70000000
.section .data
 
.dword 0x00000000000000cf 
.skip (0x700000d0 - 0x70000000 -8 )
.dword 0x000000001c0800c9          
 
.skip (0x70001000 - 0x700000d0 -8 )
.dword 0x000000001c000001
 
.skip (0x70001100 -0x70001000 - 8 )
.dword 0x000000001c000001             
 
.skip (0x70002000 -0x70001100 - 8 )
.dword 0x000000001c000401
