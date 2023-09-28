#
# Program Name: logicTestValidCharMain.s
# Date: 7/24/2023
# Purpose: Use logical tests to see if input is a valid character (upper or lowercase letter)
# Inputs: 
#   -test_char: character to evaluate 
# Output:
#   -console pass or fail
#

#   test_char valid if:
#       >= 0x41 AND <=5a
#       or
#       >= 0x61 AND <=7a
#   r5 store test_char (input)
#   r6 Logical value for whether or not the char is found to be true
#       Initialize to 0, then make 1 if char found to be valid
#   r7 Temp logical value for checking min value
#   r8 Temp logical value for checking max value
#   r9 Temp logical value
#

.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt and read into test_char, store in r5
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =test_char
    BL scanf
    LDR r5, =test_char
    LDR r5, [r5] // r5 contains test_char

    # initialize r6 to 0 (logical var for if char is valid)
    MOV r6, #0

    # check if >= 0x41 AND <=5a
    # initialize r7 and r8 to 0, make them 1 if their check passes
    MOV r7, #0
    MOV r8, #0
    CMP r5, #0x41
    MOVGE r7, #1 //r7 true if GE

    CMP r5, #0x5a
    MOVLE r8, #1 //r8 true if LE

    # set r6 true if both r7 and r8
    AND r6, r7, r8 


    # check if >= 0x61 AND <=7a
    # initialize r7 and r8 to 0, make them 1 if their check passes
    MOV r7, #0
    MOV r8, #0
    CMP r5, #0x61
    MOVGE r7, #1 //r7 true if GE

    CMP r5, #0x7a
    MOVLE r8, #1 //r8 true if LE
    # set r9 temp val true if both r7 and r8
    AND r9, r7, r8 

    # if r9 or r6, set r6
    ORR r6, r6, r9

    # If r6, then print valid_char_msg, else invalid_char_msg
    CMP r6, #1
    BLT notValidError
        LDR r0, =valid_char_msg
        BL printf
        B endError

    notValidError:
        LDR r0, =invalid_char_msg
        BL printf
    
    endError:

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
test_char: .word 0
prompt_a: .asciz "\nEnter a character: "
valid_char_msg: .asciz "\nCharacter is valid!\n"
invalid_char_msg: .asciz "\nInvalid character!\n"
format: .asciz "%s"
