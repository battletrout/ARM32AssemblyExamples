#
# Program Name: maxOf3Main.s
# Date: 7/24/2023
# Purpose: declares and implements findMaxOf3(int val1, int val2, int val3)
# Inputs: 
#   -int val1, int val2, int val3
# Output:
#   -console max value
#

#   test_char valid if:
#       >= 0x41 AND <=5a (upper)
#       or
#       >= 0x61 AND <=7a (lower)
#


.global main
.global findMaxOf3

.text
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt and read into va11, store in r4
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =val1
    BL scanf
    LDR r4, =val1
    LDR r4, [r4]

    # Prompt and read into val2, store in r5
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =val2
    BL scanf
    LDR r5, =val2
    LDR r5, [r5]

    # Prompt and read into val3, store in r6
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =val3
    BL scanf
    LDR r6, =val3
    LDR r6, [r6]

    # Put val1 r0, val2 r1, val3 r2
    MOV r0, r4
    MOV r1, r5
    MOV r2, r6

    # Call the function
    BL findMaxOf3

    # Move into r1 and output
    MOV r1, r0
    LDR r0, =largest_val_msg
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
val1: .word 0
val2: .word 0
val3: .word 0
prompt_a: .asciz "\nEnter a number: "
largest_val_msg: .asciz "\nThe largest value is: %d\n"
format: .asciz "%d"

# END OF MAIN

.text
findMaxOf3:
# Purpose: take three values, output the max
# Inputs: (int r0, int r1, int r2)
# Outputs: (r0 is int value of the largest val)

#   compare r0 to r1, take the larger value into r0
#   compare r0 to r2, take the larger value into r0
#   return r0

    SUB sp, sp, #4
    STR lr, [sp, #0]

    CMP r0, r1
    MOVLT r0, r1

    CMP r0, r2
    MOVLT r0, r2

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data

# END OF findMaxOf3