#
# Program Name: branchValidCharMain.s
# Date: 7/24/2023
# Purpose: Use branching to see if character is valid (character is valid if lower case letter or upper case letter)
# Inputs: 
#   -test_char: character to evaluate 
# Output:
#   -console pass or fail
#

#   test_char valid if:
#       >= 0x41 AND <=5a (upper)
#       or
#       >= 0x61 AND <=7a (lower)
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

    # check if >= 0x41 AND <=0x5a
    # first, if it's LE 0x5a, goto 
    CMP r5, #0x5a
    BGT checkLower
        # If it is less than 0x5a, we want to check if it is GT 0x41
        CMP r5, #0x41
        BLT invalidChar
        # if GE 0x41, it's valid
        B validChar

    checkLower:
        CMP r5, #0x7a
        BGT  invalidChar
            # check GT 0x61
            CMP r5, #0x61
            BLT invalidChar
            B validChar
    
    # come here if valid
    validChar:
        LDR r0, =valid_char_msg
        BL printf
        B endCheck

    # come here if invalid
    invalidChar:
        LDR r0, =invalid_char_msg
        BL printf
        B endCheck

    # end here either way
    endCheck:
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
test_char: .word 0
prompt_a: .asciz "\nEnter a character: "
valid_char_msg: .asciz "\nCharacter is valid!\n"
invalid_char_msg: .asciz "\nInvalid character!\n"
format: .asciz "%s"
