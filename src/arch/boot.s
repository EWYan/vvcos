.extern _start_rs
.extern __stack_end


.global _start
.global und_exp
.global sysvallhdl
.global prefetch_exp
.global dataabt_exp
.global irqhdl
.global fidhdl
.global _vector_tbl


_vector_tbl:
    ldr pc, _start
    ldr pc, und_exp
    ldr pc, syscall
    ldr pc, prefetch_exp
    ldr pc, dataabt_exp
    b   .
    ldr pc, irqhdl
    ldr pc, fidhdl


_start:
    mov r0, #0
    mrs r4, cpsr
    msr spsr_fsxc, r4
    ldr r0, =__stack_end
    cps #0x1F
    mov sp, r0
    mov lr, #0
    ldr r8, =0x2000
    sub r0, r0, r8
    cps #0x17
    mov sp, r0
    mov lr, #0
    msr spsr_fsxc, r4
    ldr r8, =0x100
    sub r0, r0, r8
    cps #0x1B
    mov sp, r0
    mov lr, #0
    msr spsr_fsxc, r4
    ldr r8, =0x100
    sub r0, r0, r8
    cps #0x12
    mov sp, r0
    mov lr, #0
    msr spsr_fsxc, r4
    ldr r8, =0x400
    sub r0, r0, r8
    cps #0x11
    mov r8, #0
    mov r9, #0
    mov r10, #0
    mov r12, #0
    mov sp, r0
    mov lr, #0
    msr spsr_fsxc, r4
    ldr r8, =0x200
    sub r0, r0, r8
    cpsid i, #0x13
    mov sp, r0

    cps #0x1F
    cpsid if
    b _start_rs



.align 4
.type und_exp, %function
und_exp:
    b   .

.align 4
.type syscall, %function
syscall:
    b   .

.align 4
.type prefetch_exp, %function
prefetch_exp:
    b   .

.align 4
.type dataabt_exp, %function
dataabt_exp:
    b   .

.align 4
.type irqhdl, %function
irqhdl:
    b   .

.align 4
.type fidhdl, %function
fidhdl:
    b   .