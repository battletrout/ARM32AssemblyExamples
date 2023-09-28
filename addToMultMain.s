#
# Program Name: addToMultMain.s
# Date: 7/31/2023
# Purpose: Use addition recursively to multiply
# Inputs: 
#   -int mult_0 (first operand)
#   -int mult_1 (second operand)
# Output:
#   -console total value
#
# Note this one did not use the correct registers for Procedure Call Standard for Arm Architecture 

.text
.global main
main:
    # Push the link register onto the stack
    SUB sp, sp, #4
    STR lr, [sp]

    # prompt for mult_0 (first operand)
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =mult_0
    BL scanf

    LDR r0, =mult_0
    LDR r0, [r0]
    # Put mult_0 in r7
    MOV r7, r0
    
    # prompt for mult_1 (second operand)
    LDR r0, =prompt_b
    BL printf
    LDR r0, =format
    LDR r1, =mult_1
    BL scanf

    LDR r0, =mult_1
    LDR r0, [r0]
    # mult_1 is in r0
    # Put mult_0 in r1 for call to multAdd
    MOV r1, r7
    
    BL multAdd
    MOV r1, r0

    LDR r0, =output
    BL printf

    # Pop the stack back into the link register
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
    prompt_a: .asciz "\nEnter the first int to multiply:  "
    prompt_b: .asciz "\nEnter the second int to multiply:  "
    output: .asciz "\n Your product is %d\n"
    format: .asciz "%d"
    mult_0: .word 0
    mult_1: .word 0

#END main

.text
multAdd:
# Purpose: take two ints, return the product by recursively adding
# Inputs: 
#   - int r0 : starts with mult_1, increments down with each call
#   - int r1 : stays mult_0, the value added each call 
# Outputs: int r0 product
# 

    SUB sp, sp, #12
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    
    # Save arguments in r4 and r5
    MOV r4, r0
    MOV r5, r1

    # if (n == 1) return m
    CMP r4, #1
    BNE Else
        MOV r0, r5
        B Return

    # else return m + multAdd(m-1,n)
    Else:
        SUB r0, r0, #1
        BL multAdd
        ADD r0, r5, r0
        B Return
    EndIf:
        
    Return: 
    LDR lr, [sp]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr
.data

#END multAdd
