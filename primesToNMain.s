#
# Program Name: primesToNMain.s
# Date: 7/25/2023
# Purpose: calculate all the prime numbers from 3...n (where n is an input int)
# Inputs: 
#   -int maxCheckVal (n)
# Output:
#   -console primes up to maxCheckVal
#

#   Dictionary: (OL = Outer Loop, IL = Inner Loop)
#   r9 : maxCheckValue ("n") (max OL iteration)
#   r7 : prime flag (0 if not prime, )
#   r6 : current OL value to check if it's prime (start @ 3)
#   r5 : current IL value to check if current OL val is divisible by
#   r4 : current OL value / 2 (max inner loop iteration)
#   

.global main

.text
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt and read into maxCheckVal, store in r4
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =maxCheckVal
    BL scanf
    LDR r9, =maxCheckVal
    LDR r9, [r9]

    # print newline
    LDR r0, =newline
    BL printf

    # Initialize outer loop starting point
    MOV r6, #3

    # outer loop: iterate r6 from 3...maxCheckVal
    StartOuterLoop:
        # Check if we've reached maxCheckVal
        CMP r6, r9
        BGT EndOuterLoop

        # Outer loop block: r4 = r6val/2
        MOV r1, #10
        MUL r0, r6, r1
        # r0 is r6 * 10, divide by 20
        MOV r1, #20
        BL __aeabi_idiv
        # r0 is r6val/2, add 1 in case of rounding down, move to r4
        ADD r0, r0, #1
        MOV r4, r0

        # Start inner loop with r4 as max value, r5 = 2 as start val
        MOV r5, #2
        StartInnerLoop:
            # check if r5 GT r4 (means r6 is prime)
            CMP r5, r4
            BGT PrintNumInnerLoop

            # InnerLoop block
            # Check for remainder when dividing r6 / r5
            MOV r0, r6
            MOV r1, r5
            BL rem
            CMP r0, #0
            # If equal, there is no remainder; end inner loop
            BEQ EndInnerLoop  
            # If not equal, increment and go back to StartInnerLoop    
            ADD r5, r5, #1
            B StartInnerLoop

        PrintNumInnerLoop:
            # We have stepped 2..n/2 without remainder; print val and exit inner loop
            MOV r1, r6
            LDR r0, =largest_val_msg
            BL printf
            B EndInnerLoop
        
        EndInnerLoop:
            # Increment r6
            ADD r6, r6, #1
            B StartOuterLoop
        
    EndOuterLoop:
        LDR lr, [sp, #0]
        ADD sp, sp, #4
        MOV pc, lr

.data
maxCheckVal: .word 0
prompt_a: .asciz "\nEnter a number: "
newline: .asciz "\n"
largest_val_msg: .asciz "%d \n"
format: .asciz "%d"

# END OF MAIN

.text
rem:
# Purpose: take a dividend and divisor and output remainder
# Inputs: (int r0, int r1)
# Outputs: r0 (remainder of r0/r1)

    # push stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # retain r0 in r7
    MOV r7, r0
    # divide r0 by r1
    BL __aeabi_idiv
    # multiply the result by the divisor, r1
    MUL r0, r0, r1
    # subtract r0 from r7 to get the remainder
    SUB r0, r7, r0

    # pop stack
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data

# END OF rem