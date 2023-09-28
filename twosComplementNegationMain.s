# Filename: twosComplementNegationMain.s
# Take input integer, negate it as two's complement, output the result

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

    #Negate, then add 1
    MVN r2, r4
    ADD r1, r2, #1

    LDR r0, =output
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
integer:  .word 0
prompt_a: .asciz "\nEnter value to negate: "
output: .asciz "\nNegated value is %d\n"
format: .asciz "%d"
