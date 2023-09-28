#
# Program Name: fibNumMain.s
# Date: 7/31/2023
# Purpose: Use recursion to calculate Fibonacci number up to n; 
# good example of using a stack to store values in recursion.
# Inputs: 
#   -int max_num (number to calculate to, "n")
# Output:
#   -console fibonacci number
#

.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp]

    # prompt for max_num (n)
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =max_num
    BL scanf

    LDR r0, =max_num
    LDR r0, [r0]
    # Put max_num in r7
    MOV r7, r0
    
    MOV r5, #0
    BL Fib

    LDR r0, =output
    BL printf

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
    prompt_a: .asciz "\nEnter the Fibonacci max number:  "
    output: .asciz "\n Your total is %d\n"
    format: .asciz "%d"
    max_num: .word 0

#END main

.text
Fib:
# Purpose: take one int, calculate fib sequence up to that value
# Inputs: 
#   - int r0 : starting number
# Outputs: int r1 Fib number
# 
# r0 will count down to 0
# r1 is the running total

    SUB sp, sp, #8
    STR lr, [sp]
    # push current n
    STR r0, [sp, #4]
    
    # if (n >= 2) recurse; otherwise, push 1 onto the stack (should be n=0 or 1)
    CMP r0, #2
    BGE Else
        # If 
        MOV r1, #1
        B Return

    # else return Fib(n-1) + Fib(n-2)
    Else:
        # n -= 1
        SUB r0, r0, #1
        BL Fib

        # r1 holds Fib(n-1), push on the stack, set to 0
        SUB sp, sp, #4
        STR r1, [sp]
        MOV r1, #0

        # n -= 2
        SUB r0, r0, #1
        BL Fib
        # r1 holds Fib(n-2)

        # pop result of n-1 into r2
        LDR r2, [sp]
        ADD sp, sp, #4

        # r1 = r1 + r2
        ADD r1, r2, r1
        B Return
    EndIf:
        
    Return: 
    LDR lr, [sp]
    # pop current n into r0
    LDR r0, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr
.data

#END Fib
