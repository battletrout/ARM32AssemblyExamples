#
# Program Name: milesHours2kphMain.s
# Date: 7/20/2023
# Purpose: Calculates kph from miles and hours, calling functions from libConversions
# Inputs: 
#   -miles: int distance in miles
#   -hours: int time in hours
#
.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt and read into miles, store in r4
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =miles
    BL scanf
    LDR r4, =miles
    LDR r4, [r4] // r4 contains miles

    # Prompt and read into hours, store in r5
    LDR r0, =prompt_b
    BL printf
    LDR r0, =format
    LDR r1, =hours
    BL scanf
    LDR r5, =hours
    LDR r5, [r5] //r5 contains the remaining distance in hours

    # Call kph: Inputs (r0, r1) r0:int hours, r1:int miles
    MOV r0, r5
    MOV r1, r4
    BL kph
    # r0 now has speed in kph
    # MOV speed (r0) to r1 for output
    MOV r1, r0

    # Output
    LDR r0, =output
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
miles: .word 0
hours:  .word 0
prompt_a: .asciz "\nEnter distance in miles: "
prompt_b: .asciz "\nEnter time in hours: "
output: .asciz "\nSpeed is %d kph\n"
format: .asciz "%d"
