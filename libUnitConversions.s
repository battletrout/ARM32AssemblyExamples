#
# Program Name: libUnitConversions.s
# Date: 7/20/2023
# Purpose: Contains functions for conversions that are called by other functions
# 
#

.global miles2kilometers
.global kph
.global CToF
.global InchesToFt

.text

miles2kilometers: 
# Purpose: take input in miles, output in km
# Inputs: (r0 is int value in miles)
# Outputs: (r0 is int value in km)

    # push stack with current link register to restore on exit
    SUB sp, sp, #4
    STR lr, [sp]
    
    # r0 = r0 * 16/10 
    # We multiply times 16 and divide by 10 instead of multiply * 1.6 
    # because we're operating with integers and it will give us a more precise answer
    MOV r1, #16
    MUL r0, r0, r1
    MOV r1, #10
    BL __aeabi_idiv

    # pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

#END miles2kilometers

.text

kph:
# Purpose: take input in hours and miles, output in kph
# Inputs: (r0, r1) r0:int hours, r1:int miles
# Outputs: (r0 is int value in kph)

    # push stack with current link register to restore on exit
    SUB sp, sp, #4
    STR lr, [sp]

    # Preserve r0 (hours) in r4 
    MOV r4, r0
    MOV r0, r1
    # Convert miles to km
    BL miles2kilometers

    # move r4 (hours) into r1
    MOV r1, r4    
    # Divide by the number of hours
    BL __aeabi_idiv    

    # pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    # Return the link register to the pc register
    # this puts us back in sequential execution after completing the function
    MOV pc, lr
.data

#END kph

.text

CToF:
# Purpose: take input in C, output in F
# Inputs: (r0 int temp in C)
# Outputs: (r0 is int value in F)

    # push stack with current link register to restore on exit
    SUB sp, sp, #4
    STR lr, [sp]

    MOV r1, #9
    MUL r0, r0, r1 // r0 = Celsius * 9

    # Divide
    MOV r1, #5
    BL __aeabi_idiv

    # Add
    MOV r1, #32
    ADD r0, r0, r1 // r0 = quotient + 32

    # pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    # Return the link register to the pc register
    # this puts us back in sequential execution after completing the function
    MOV pc, lr
.data

#END CToF

.text

InchesToFt:

# Purpose: take input in In, output in Ft (rounds down to nearest ft)
# Inputs: (r0 int distance in In)
# Outputs: (r0 is distance value in Ft)

    # push stack with current link register to restore on exit
    SUB sp, sp, #4
    STR lr, [sp]

    # Divide
    MOV r1, #12
    BL __aeabi_idiv

    # pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    # Return the link register to the pc register
    # this puts us back in sequential execution after completing the function
    MOV pc, lr
.data

#END InchesToFt