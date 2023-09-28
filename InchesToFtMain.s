#
# Program Name: InchesToFtMain.s
# Date: 7/20/2023
# Purpose: Calculates dist in Ft from Inches, calling functions from libUnitConversions
# Inputs: 
#   -inches: distance in In
#
.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt and read into inches, store in r5
    LDR r0, =prompt_b
    BL printf
    LDR r0, =format
    LDR r1, =inches
    BL scanf
    LDR r5, =inches
    LDR r5, [r5] 

    # Call InchesToFt
    MOV r0, r5
    BL InchesToFt
    # r0 now has temp in C
    # MOV speed (r0) to r1 for output
    MOV r1, r0

    # Output
    LDR r0, =output
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
inches: .word 0
prompt_b: .asciz "\nEnter distance in In: "
output: .asciz "\nDistance is %d Feet (rounded down)\n"
format: .asciz "%d"
