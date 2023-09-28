#
# Program Name: libSampleAConversions.s
# Author: Nathan Kemp
# Date: 7/20/2023
# Purpose: Contains functions for conversions that can be called by other programs if linked.
#       No programs call them in this collection of examples, but you can make your own. 
# 

.global Ft2Inches
.global F2C

.text
F2C: 
# Purpose: take input in Fahrenheit, output in Celsius
# Inputs: (r0 is int value in F)
# Outputs: (r0 is int value in C)

    # push stack with current link register to restore on exit
    SUB sp, sp, #4
    STR lr, [sp]
    
    # r0 = (r0-32)*5/9
    MOV r1, #-32
    ADD r0, r0, r1
    MOV r1, #5
    MUL r0, r0, r1
    MOV r1, #9
    BL __aeabi_idiv

    # pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
#END F2C

.text
Ft2Inches:
# Purpose: take input in Feet, output in In
# Inputs: (r0 is int value in Feet)
# Outputs: (r0 is int value in Inches)

    # push stack with current link register to restore on exit
    SUB sp, sp, #4
    STR lr, [sp]

    # Convert feet to inches
    # assumes feet is in r0
    MOV r1, #12
    MUL r0, r0, r1

    # pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    # Return the link register to the pc register
    # this puts us back in sequential execution after completing the function
    MOV pc, lr
.data

#END Ft2Inches

