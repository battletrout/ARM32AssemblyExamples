#
# Program Name: CToFMain.s
# Date: 7/20/2023
# Purpose: Calculates temp in F from C, calling functions from libUnitConversions
# Inputs: 
#   -cent: Temp in C
#
.text
.global main
main:
    # Push the LR onto the Stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt and read into Cent, store in r5
    LDR r0, =prompt_b
    BL printf
    LDR r0, =format
    LDR r1, =cent
    BL scanf
    LDR r5, =cent
    LDR r5, [r5] 

    # Call CToF
    MOV r0, r5
    BL CToF
    # r0 now has temp in F
    # MOV speed (r0) to r1 for output
    MOV r1, r0

    # Output
    LDR r0, =output
    BL printf

    # Pop the stack onto the LR, move LR to PC
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
cent: .word 0
prompt_b: .asciz "\nEnter temp in C: "
output: .asciz "\nTemp is %d degrees F\n"
format: .asciz "%d"
