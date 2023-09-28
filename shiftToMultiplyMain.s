# Filename: shiftToMultiplyMain.s
# Read an integer as input, multiply it times 10 using Logical Shift Left (LSL) and add

.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    #Prompt and read into integer, store in r4
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =integer
    BL scanf
    LDR r4, =integer
    LDR r4, [r4] // r4 contains the integer

    #Shift left 3 times (*8), then add twice
    LSL r1, r4, #3
    ADD r1, r1, r4
    ADD r1, r1, r4

    LDR r0, =output
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
integer:  .word 0
prompt_a: .asciz "\nEnter value to multiply times 10: "
output: .asciz "\nVal times 10: %d\n"
format: .asciz "%d"
