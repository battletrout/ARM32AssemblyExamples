#
# Program Name: swapRegsInPlaceXOR.s
# Date: 7/20/2023
# Purpose: Swaps two registers in place using Exclusive OR (XOR, the EOR command)
# 
#
.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Initially: 4 in r4, 5 in r5
    MOV r4, #4
    MOV r5, #5

    # Output Initial State
    LDR r0, =output
    MOV r1, r4
    MOV r2, r5
    BL printf

    # Swapping message
    LDR r0, =prompt_a
    BL printf

    # XOR r4, r5, then XOR r5, r4, then XOR r4, r5
    EOR r4, r4, r5
    EOR r5, r4, r5
    EOR r4, r4, r5

    # Output Final State
    LDR r0, =output
    MOV r1, r4
    MOV r2, r5
    BL printf    

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
integer:  .word 0
prompt_a: .asciz "\nSwapping... \n"
output: .asciz "\nr4: %d r5: %d\n"
